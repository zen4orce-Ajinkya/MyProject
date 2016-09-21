public class TimeStampHandlerClass {
  
   public  static void BeforeInsertCheakForStateTimeStampUpdate(List<Lead> newLeadList)
    {
          Map<Decimal,TimeStamp__c> AreaCode= new Map<Decimal,TimeStamp__c>();
         
       
        //system.debug('newlead'+phoneAreaCode.get('402'));
        
        for(TimeStamp__c ts:[select AreaCode__c,TimeZone__c,State__c from TimeStamp__C])
        { 
            AreaCode.put(ts.AreaCode__c,ts);
        }
 		
        for(Lead l: newLeadList)
        {    
            try{
            if(AreaCode.containsKey(Double.valueOf(l.Phone.substring(1,4))))
         {
             l.State__c=AreaCode.get(Double.valueOf(l.Phone.substring(1,4))).State__c;
             l.Time__c=AreaCode.get(Double.valueOf(l.Phone.substring(1,4))).TimeZone__c;
         }
            }
            catch(Exception e)
            {
                l.Phone.addError('Record with same eamil already Present');
            }
            
          
        
        }
        
    }

    
}