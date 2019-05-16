global with sharing class DiscoveryRecommendationsHelper {



public static NbaResponse getChurnPredictionHelper(String recordId){

NbaResponse res = new NbaResponse();
res.baseLine = 0;
res.total = 0;

try{

ConnectApi.SmartDataDiscoveryPredictInputRawData input = new ConnectApi.SmartDataDiscoveryPredictInputRawData();
input.predictionDefinition = '0OR7A0000000001WAA';

Account rec = [select Sentiment__c, LifeStage__c, MissingMortgagePayments__c, RetentionTeam__c from Account where Id =: recordId];

/*List<List<String>> rows = new List<List<String>>{
    new List<String>{rec.Sentiment__c, rec.LifeStage__c, rec.MissingMortgagePayments__c, rec.RetentionTeam__c}
};
*/

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
        res.baseLine = po.prediction.baseLine;
        res.total = po.prediction.total;
    }
}

//PredictionDef parse(String json);

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
    
    /*
    List<Recommendation> recs = new List<Recommendation>(); 
    for (Account account:accounts) {
        if (account.LastContactDate__c != null){
            lastContactDate = account.LastContactDate__c;
            daysSinceLastContact = lastContactDate.daysBetween(todayDate);
            if (daysSinceLastContact > 30){
                Recommendation rec = new Recommendation(
                    Name = account.Name,
                    Description = 'Connect with the ' + account.Name + ' account, the last interaction was '+ daysSinceLastContact + ' days ago.',
                    ActionReference = 'simpleFlow',
                    AcceptanceLabel = 'View'
                );
                recs.add(rec);
            }
        }
    }
    outputs.add(recs);
    */

    return outputs; 
}

}