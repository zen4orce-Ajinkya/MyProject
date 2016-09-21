trigger DeDupeCheck on Lead (before insert,after insert,before update) {
    
      if(Trigger.isBefore)
      {
    
        if(Trigger.isInsert)
        {
           LeadHealperClass.DuplicateLeads(Trigger.new);
           TimeStampHandlerClass.BeforeInsertCheakForStateTimeStampUpdate(Trigger.new);
         //LeadHealperClass.DuplicateLeadsByMap(Trigger.newMap); 
        }  
        
        if(trigger.isUpdate)
        {
           LeadHealperClass.LeadBeforeUpdate(Trigger.old,Trigger.new);
        }
          
      } 
       if(trigger.isAfter)
     {
        
        if(trigger.isInsert)
        {
            LeadHealperClass.createTask(Trigger.new);
            LeadHealperClass.CloneLeadAfterInsert(Trigger.new);
          
        }
    }
    
}