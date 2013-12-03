public class HWFrontController {
    public JsonObject json {get;set;}
     
    /** invoked on an Ajax request */   
    public void doRoute() {
        Map<string,Object> params = ApexPages.currentPage().getParameters();
        json = new JsonObject();
         
         
         
         
          if (params.get('action')!=null) {
         String action=(String)params.get('action'); // action1
         String parameterss=(String)params.get('parameters');
        
        
Map<String, Object> parameters = new Map<String, Object>();
parameters.put('ParametersData', parameterss);
parameters.put('B', 'Robots');


String serialized = System.JSON.serialize(parameters);
//System.debug('XXXXXXX1'+serialized);


parameters = (Map<String, Object>) System.JSON.deserializeUntyped(serialized);
//System.debug('XXXXXXX2'+parameters.get('ParametersData'));
//System.debug('XXXXXXX3'+JsonUtils.JSENCODE((String)parameters.get('ParametersData'))  );
      
 /*
DEBUG|XXXXXXX1{"ParametersData":"{\"q\":\"a\"}","B":"Robots"}
DEBUG|XXXXXXX2{"q":"a"}
DEBUG|XXXXXXX4{"q":"a"}
XXXXXXX4action1
 */       
        

//Here We Get The Action
//Here We Get The Request Parameters
//Then We can make routing based on actions and parameters


Parms prs = (Parms)System.JSON.deserialize(JsonUtils.JSENCODE((String)parameters.get('ParametersData')),Parms.class);
//System.debug('this is the real parameters object'+prs.q);
           
//system.debug('XXXXXXX4'+action);
    

//Here Is the Code for Router

if(action=='action1'){


         
        // Do SOQL query to see if there are any records !
        List<Contact> records = getRecords(prs.q);//params.get('q')
         
        if (!records.isEmpty()) {
            // Jsonify the results !
            List<JSONObject.value> values = new List<JSONObject.value>();
            for (Contact c : records) {
                JSONObject cjson = new JSONObject();
                cjson.putOpt('name', new JSONObject.value(c.Name));
                cjson.putOpt('email', new JSONObject.value(c.email));
                values.add(new JSONObject.value(cjson));
            }  
            json.putOpt('contacts', new JSONObject.value(values));
             
        }
        }
        
  if(action=='action2')
  {
  
  //Do Action 2
  
  }
  
  }//if there is an action
        
    }
     
    // Does the SOQL query, using Ajax request data
    public List<Contact> getRecords(String contactName) {
    system.debug('contactNameXXXXXXX5 '+contactName);
    
        List<Contact> records = new List<Contact>();
        if (contactName != null && contactName.trim().length() > 0){
            // Protect from SOQL injection           
            String contactNameToFilter = '%' + contactName  + '%';
            records = [select id, name, email from contact where Name like :contactNameToFilter];
             
        }  
        return records;     
    }   
 
    // Returns the JSON result string
    public String getResult() {
        return json.ValuetoString();
    }
    
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    
class Parms
{
 String q;

List<remainder> defaultReminders;

} 
class remainder
{
     String method;
    String minutes;
}

   
     
}