global with sharing class PredictionHelper {


global class NbaRequest{
    @InvocableVariable(required=false)
    public String sEmail;
    @InvocableVariable(required=false)
    public String custid;
}

global class NbaResponse{
    @InvocableVariable
    global Integer baseLine;
    @InvocableVariable
    global Integer total;
}

@InvocableMethod(label='GetChurnPrediction')
global static List<NbaResponse>GetChurnPrediction(List<NbaRequest> requests)
{
    List<NbaResponse> oList = new List<NbaResponse>();

    NbaResponse res = getChurnPredictionHelper();

    
    oList.add(res);
    
    return oList;
}

public static NbaResponse getChurnPredictionHelper(){

NbaResponse res = new NbaResponse();
res.baseLine = 0;
res.total = 0;


try{

//List<String> entityIds = new List<String> {'006RM000002bEfZYAU', '006RM000002bEfcY'};

ConnectApi.SmartDataDiscoveryPredictInputRawData input = new ConnectApi.SmartDataDiscoveryPredictInputRawData();
input.predictionDefinition = '9B41k0000008OIACA2';

List<List<String>> rows = new List<List<String>>{
    new List<String>{'Negative', 'Increase', 'Yes', 'Retired'}
};

List<ConnectApi.SmartDataDiscoveryRowNestedList> li = new List<ConnectApi.SmartDataDiscoveryRowNestedList>();

ConnectApi.SmartDataDiscoveryRowNestedList o = new ConnectApi.SmartDataDiscoveryRowNestedList();
o.row = new List<String>{'Negative', 'Increase', 'Yes', 'Retired'};

li.add(o);

input.rows = li;
input.columnNames = new List<String>{'Sentiment__c', 'LifeStage__c', 'MissingMortgagePayments__c', 'RetentionTeam__c'};
  
System.debug('SmartDataDiscoveryPrediction input - ' + input);  
  
ConnectApi.SmartDataDiscoveryPrediction pred = ConnectApi.SmartDataDiscovery.predict(input);

System.debug('SmartDataDiscoveryPrediction - ' + JSON.serialize(pred));

}catch(Exception e){
    System.debug('SmartDataDiscoveryPrediction error=' + e);
}

return res;

} 

}