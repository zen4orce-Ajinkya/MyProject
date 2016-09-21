@isTest

	public class TestSendEmailToOwner {

   static testMethod void CheckForSingleRecord()
   {
    //negativeInput
    Opportunity op=new Opportunity(Name='Newtestamt',CloseDate=System.today(),StageName='Closed Won',Amount=20000);
    
    try
    {
    insert op;    
    }
    catch(Exception e)
       {
          String Exceptionmsgmsg =e.getMessage();
          System.debug('Exception msg'+Exceptionmsgmsg);     
       }
    
    //possitiveInput  
    Opportunity op1=new Opportunity(Name='Amountgraterthan25000',CloseDate=System.today()-5,StageName='Closed Won',Amount=3000000);
    
   	try{
       
    	insert op1;    
   	  }
    catch(Exception e)
       {
          String Exceptionmsg = e.getMessage();
          System.debug('Exception msg'+Exceptionmsg);     
       }
   }
    
    static testMethod void CheckForBulkRecord()
   {
   	  List<Opportunity> Bulklist=new List<Opportunity>();
      
       for(Integer i=0;i<200;i++)
       {	
           Opportunity op=new Opportunity(Name=i+'Newtestamt',CloseDate=System.today(),StageName='Closed Won',Amount=i+20000);
           Bulklist.add(op);
       }
           
 
       try
    {
    	insert Bulklist;    
    }
    catch(Exception e)
       {
          String Exceptionmsgmsg =e.getMessage();
          System.debug('Exception msg'+Exceptionmsgmsg);     
       }
      
   }
        
    
    static testMethod void CheckForBulkRecordPossitiveInputUpdate() 
    {
       List<Opportunity> Bulklist=new List<Opportunity>();
 	   for(Integer i=0;i<200;i++)
       {	
           Opportunity op=new Opportunity(Name=i+'Newtestamt',CloseDate=System.today(),StageName='Closed Won',Amount=i+20000);
           Bulklist.add(op);
       }
    
   try{
       insert Bulklist;    
   	  }
        
    catch(Exception e)
       {
          String Exceptionmsg = e.getMessage();
          System.debug('Exception msg'+Exceptionmsg);     
       }
        
       List<Opportunity> oldOpp =new List<Opportunity>([select amount,id,name from Opportunity]);
       
        for(integer i=0;i<200;i++)
        {
         oldOpp.get(i).amount=25600+i;
        }
             update oldOpp;
    
    }	
 
        static testmethod void SingleRecordUpdate()
     {
  
        Opportunity op=new Opportunity(Name='Newtestamt',CloseDate=System.today(),StageName='Closed Won',Amount=20000);         
        insert op;
        op.Amount=300000;
        update op;
      
 
     }
        
     
        
}