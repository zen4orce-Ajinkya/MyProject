trigger SendEmailToOwner on Opportunity (after insert) {
    if(Trigger.isAfter)
    {
    	if(Trigger.isInsert)
    	{
			SendEmailToOppManager.sendEmailToM(Trigger.new);
    	}
    
    }
       
    
}