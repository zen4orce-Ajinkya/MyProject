public class SendEmailToOppManager {
   public static void sendEmailToM(List<Opportunity> listopp)
      {
         Id templateID=[select id, name from EmailTemplate where developername = 'notify_the_manager'].id;
         List<id> ownerIdList=new List<id>();
         
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
	      email.setTemplateId(templateId);
          email.setTargetObjectId(managerId);
          email.setSaveAsActivity(false);
          messages.add(email);
              
          }
         
          Messaging.sendEmail(messages);
		
        
   }
    
}