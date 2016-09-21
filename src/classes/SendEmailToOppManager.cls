public class SendEmailToOppManager {
   public static void sendEmailToM(List<Opportunity> listopp)
      {
            EmailTemplate et =[select id, name from EmailTemplate where developername = 'notify_the_manager'];
         	List<id> ownerIdList=new List<id>();
            ID templateID=et.Id;
         
         for(Opportunity op:listopp)
         {
             if(op.Amount>25000)
             {
                 
              ownerIdList.add(op.CreatedById);
             }
         }
          
          List<user> ownerlist=new List<user>([select id,ManagerCustom__r.email from user where id in:ownerIdList]);
          Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>(); 
          
          for(user u : ownerlist)
          {
          id managerid = u.ManagerCustom__r.id;  
          String managerEmail = u.ManagerCustom__r.email;      
          Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
          email.ToAddresses=new String[]{ managerEmail};
	      email.setTemplateId(templateID);
          email.setTargetObjectId(managerId);
          email.setSaveAsActivity(false);
          messages.add(email);
              
          }
         
          Messaging.sendEmail(messages);
		
        
   }

    
     public static void sendEmailToMUpdate(Map<id,Opportunity> mapopp,Map<id,Opportunity> mapoppOld)
      {
            EmailTemplate et =[select id, name from EmailTemplate where developername = 'notify_the_manager'];
         	List<id> ownerIdList=new List<id>();
            ID templateID=et.Id;
            system.debug(templateID);
          
          for(ID old : mapoppOld.keySet())
          {
              system.debug(mapoppOld.get(old).amount<25000 && mapopp.get(old).amount>25000);
                if(mapoppOld.get(old).amount<25000 && mapopp.get(old).amount>25000)
                {
                    ownerIdList.add(mapopp.get(old).createdByid);
                    
                }
          }
              
         
          List<user> ownerlist=new List<user>([select id,ManagerCustom__r.email from user where id in:ownerIdList]);
          Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>(); 
          
          for(user u : ownerlist)
          {
          id managerid = u.ManagerCustom__r.id;  
          String managerEmail = u.ManagerCustom__r.email;      
          Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
          email.ToAddresses=new String[]{ managerEmail};
	      email.setTemplateId(templateID);
          email.setTargetObjectId(managerId);
          email.setSaveAsActivity(false);
          messages.add(email);
              
          }
         
          Messaging.sendEmail(messages);
		
        
   }
   
}