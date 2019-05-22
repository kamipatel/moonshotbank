global with sharing class DiscoveryRecommendationsHelper {

public static ConnectApi.SmartDataDiscoveryPredictObject getDiscoveryPrediction(String recordId){

ConnectApi.SmartDataDiscoveryPredictObject res = null;

try{

ConnectApi.SmartDataDiscoveryPredictInputRawData input = new ConnectApi.SmartDataDiscoveryPredictInputRawData();
input.predictionDefinition = '0OR7A0000000001WAA';

Account rec = [select Sentiment__c, LifeStage__c, MissingMortgagePayments__c, RetentionTeam__c from Account where Id =: recordId];


List<ConnectApi.SmartDataDiscoveryRowNestedList> li = new List<ConnectApi.SmartDataDiscoveryRowNestedList>();

ConnectApi.SmartDataDiscoveryRowNestedList o = new ConnectApi.SmartDataDiscoveryRowNestedList();
o.row = new List<String>{rec.Sentiment__c, rec.LifeStage__c, rec.MissingMortgagePayments__c, rec.RetentionTeam__c};

li.add(o);

input.rows = li;
input.columnNames = new List<String>{'Account.Sentiment__c', 'Account.LifeStage__c', 'Account.MissingMortgagePayments__c', 'Account.RetentionTeam__c'};
  
System.debug('SmartDataDiscoveryPrediction input - ' + input);  
  
ConnectApi.SmartDataDiscoveryPrediction pred = ConnectApi.SmartDataDiscovery.predict(input);

System.debug('SmartDataDiscoveryPrediction - ' + JSON.serialize(pred));

if(pred != null && pred.predictions != null && pred.predictions.size() > 0){

    System.debug('SmartDataDiscoveryPrediction info - ' + JSON.serialize(pred.predictions[0]));

    if(pred.predictions[0] instanceof ConnectApi.SmartDataDiscoveryPredictObject){
        ConnectApi.SmartDataDiscoveryPredictObject po = (ConnectApi.SmartDataDiscoveryPredictObject) pred.predictions[0];
        res = po;
    }
}


}catch(Exception e){
    System.debug('SmartDataDiscoveryPrediction error=' + e);
}

System.debug('SmartDataDiscoveryPrediction res=' + JSON.serialize(res));

return res;

} 

@InvocableMethod(label='Dynamic ED recommendations' 
                    description='Generate dynamic recommendations from ED')
global static List<List<Recommendation>> invocableMethod(List<String> inputData){
    List<List<Recommendation>> outputs = new List<List<Recommendation>>();
    
    ConnectApi.SmartDataDiscoveryPredictObject pred = getDiscoveryPrediction(inputData[0]);

    List<Recommendation> recs = new List<Recommendation>(); 

    String prescription = '';
    String delim = '';
    for (ConnectApi.SmartDataDiscoveryPredictCondition condition : pred.prescriptions) {
        Decimal d = condition.value;

        for (ConnectApi.SmartDataDiscoveryPredictColumn column : condition.columns) {
            prescription += ' ' + column.columnName + ' to ' + column.columnValue;
            System.debug('SmartDataDiscoveryPrediction prescription=' + prescription);  

            Recommendation rec = new Recommendation(
                        Name = 'Do It',
                        Description = prescription,
                        ActionReference = 'RetentionFlow',
                        AcceptanceLabel = 'Do It'
                    );
            recs.add(rec);        


        }
        System.debug('SmartDataDiscoveryPrediction prescription value=' + d);  

    }

    outputs.add(recs);
    
    if (pred.prescriptions.size() == 0) {
        System.debug('SmartDataDiscoveryPrediction No changes recommended');  
    }
    
    return outputs; 
}

}