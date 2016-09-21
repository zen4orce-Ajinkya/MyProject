trigger SendEmailToOwner on Opportunity (after insert,after update) {
    if(Trigger.isAfter)
    {
        
    	if(Trigger.isInsert)
    	{
			SendEmailToOppManager.sendEmailToM(Trigger.new);
    	}
        
        if(Trigger.isUpdate)
        {
            SendEmailToOppManager.sendEmailToMUpdate(Trigger.newMap,Trigger.oldMap);
        }
        
    	
        
    }
       
    
}