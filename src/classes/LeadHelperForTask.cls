public class LeadHelperForTask {
    public static void CloneLeadBeforeUpdate(List<Lead> newLead)
    {  
       //   List<Lead> newLeads=new List<Lead>();
         // Lead newobj=new Lead();
       
        /*
            if(oldLead[0].Status=='Open-Not Contacted')
            {
                newobj =oldLead[0].clone(false,true,false,true);
                //lead.Name='abc'+l.Name;
                newobj.LastName='dsfdsf';
              /*  newobj.Company='hgjhk';
                newobj.Email='abc'+oldLead[0].Email;
                newobj.Phone='abc'+oldLead[0].Phone;
                newobj.Status='Working – Contacted';
                System.debug(newobj);
        */
           //     newLeads.add(newobj);
             //   insert newLeads;
            //}
            
        //*/
        
        
        
        
        
        
        //system.debug(oldlead);
       
        
       List<Lead> newLeads=new List<Lead>();
       Lead l;
       
        for(Integer i=0; i<newLead.size(); i++)
        {
          if(newLead[i].status== 'Open-Not Contacted')
          {
            
              
              l=newLead[i].clone(false,true,false,false); 
              system.debug('clone'+l);
            //l.Name='a'+oldLead[i].Name;
              l.Email=newLead[i] + 'ggg';
              
              l.phone='moka' + newLead[i].phone;
              l.Status='Working-Contacted';
              
              system.debug(l); 
              
              newLeads.add(l);
                
          }
           
        }
        
     //   insert newLeads;
       
     
        
            
        
        
    }

}