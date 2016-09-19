public class LeadHealperClass {
   
    public Static void DuplicateLeads(List<Lead> newList )
    {

    Map<String, Lead> leadMap = new Map<String, Lead>();
    
        for(Lead l  : [select id,Email,Phone from Lead where email !=' ' AND Phone != ' ']) 
    {
       
         leadMap.put(l.Email+l.Phone,l);
       
    }
  

    for (Lead lead :newList )
    {
       if(lead.Email !=' ' || lead.Phone !=' ')
       {
            if (leadMap.containsKey(lead.Email+lead.Phone))
            {
                lead.Email.addError('Record with same eamil already Present');
                lead.phone.addError('Record with same phone already Present');
            }
            leadMap.put(lead.Email+lead.Phone,lead);
       }
    }
    
 }
/*
  
    public Static void DuplicateLeadsByMap(Map<id,Lead> newMap )
    {
        system.debug('newMap');
        for(Lead l : [select id,email,phone,lastname,company from Lead] )
        {
             for(Lead newl : newMap.values())
             {
                 system.debug('newl');
                 if(l.Email+l.Phone ==	newl.Email+newl.phone)
                 {
             
                     newl.Email.addError('Record with same eamil already Present');
         	  	  newl.phone.addError('Record with same phone already Present');
                 }
                 
             }
            
        }
            
    
 	}
*/

    
    public static void LeadBeforeUpdate(List<Lead> oldLead,List<Lead> newLead)
    {
        Map<String, Lead> leadMap = new Map<String, Lead>();
    
        for(Lead l  : [select id,Email,Phone from Lead where email !=' ' AND Phone != ' ' And id not In:oldLead]) 
    {
       
         leadMap.put(l.Email+l.Phone,l);
       
    }
  

    for (Lead lead :newLead )
    {
       if(lead.Email !=' ' || lead.Phone !=' ')
       {
            if (leadMap.containsKey(lead.Email+lead.Phone))
            {
                lead.Email.addError('Record with same eamil already Present');
                lead.phone.addError('Record with same phone already Present');
            }
            leadMap.put(lead.Email+lead.Phone,lead);
       }
    }

 }
    
    public static void createTask(List<Lead> newLead)
    {
       List<Task> newTasks=new List<Task>();
       Task t; 
        for(Lead l : newLead )
        {
   		         t=new Task();
      	         t.WhoId=l.id;
                 t.Subject = 'Property';
                 t.Priority = 'Normal';
                 t.Status = 'Not Started';
                 t.Type = 'Action';
                 t.ownerID = l.ownerID;
                 newTasks.add(t);  
        }
       
        insert newTasks;
    }
    
    
    
     public static void CloneLeadAfterInsert(List<Lead> newLead)
    {  
         
       List<Lead> newLeads=new List<Lead>();
      
       
        for(Lead ld: newLead)
        {
          if(ld.Status== 'Open-Not Contacted')
          {
            
              Lead l=new Lead();
              l=ld.clone(false,true,false,false); 
              system.debug('clone'+l);
            //l.Name='a'+oldLead[i].Name;
              l.Email=ld.Email + 'aaa';
              l.Company=ld.Company;
              l.Phone=ld.Phone;   
              l.Status='Working-Contacted';
              system.debug(l); 
              newLeads.add(l);
                
          }
           
        }
        
       insert newLeads;
       
        
    }
    
    
    
    
}