global with sharing class ISHelper {


@InvocableMethod(label='IS recommendations' 
                    description='Generate IS recommendations')
global static List<List<Recommendation>> invocableMethod(List<String> inputData){

List<List<Recommendation>> outputs = new List<List<Recommendation>>();

/*
List<ISData.Content> contents = GetRecommendationsForCustomerKey( GetToken(), inputData[0]);

List<Recommendation> recs = new List<Recommendation>(); 

for(ISData.Content isrec : contents) {

    Recommendation rec = new Recommendation(
                        Name = isrec.name,
                        Description = isrec.description,
                        ActionReference = 'RetentionFlow',
                        AcceptanceLabel = 'Yes',
                        RejectionLabel = 'No'
                        //ImageId = isrec.imageurl
                    );
    recs.add(rec);        

}

outputs.add(recs);
*/

return outputs;

}

}


