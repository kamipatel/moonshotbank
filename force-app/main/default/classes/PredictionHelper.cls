global with sharing class PredictionHelper {


global class NbaRequest{
    @InvocableVariable(required=false)
    public String recordId;
}

global class NbaResponse{
    @InvocableVariable
    global Double baseLine;
    @InvocableVariable
    global Double total;
}

@InvocableMethod(label='GetChurnPrediction')
global static List<NbaResponse>GetChurnPrediction(List<NbaRequest> requests)
{
    List<NbaResponse> oList = new List<NbaResponse>();

    NbaResponse res = getChurnPredictionHelper(requests[0].recordId);

    System.debug('SmartDataDiscoveryPrediction total - ' + res.total);

    oList.add(res);
    
    return oList;
}

public static NbaResponse getChurnPredictionHelper(String recordId){

NbaResponse res = new NbaResponse();
res.baseLine = 0;
res.total = 0;

try{

ConnectApi.SmartDataDiscoveryPredictInputRawData input = new ConnectApi.SmartDataDiscoveryPredictInputRawData();
edconfig__mdt ed = [select Id, ed__c from edconfig__mdt limit 1];
input.predictionDefinition = ed.ed__c;

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

}