trigger addtaskonlead on Lead (after update) {
    
         List<Lead> leadlist=new List<Lead>(); 
          //Lead l=[select firstname,lastname,status,phone,email from leadlist limit 1];
        
          for(Lead l : trigger.new)
          {
             Lead cloneLead=l.clone();
             cloneLead.Email='q' + l.Email;
             cloneLead.phone='2' +l.Phone;
             id cloneleadID= cloneLead.id;
            
             insert cloneLead;
             system.debug(cloneleadID);
              //leadlist.add(cloneLead); 
             system.debug('LeadList=' +leadlist);
               
             
          }
            //insert leadlist;    
   
             /*
    system.debug(l);
          
              cloneLead=l.clone(false,true,false,false);
              cloneLead.Email= 'ajinkya' +l.Email;
              // system.debug(cloneLead);
            //insert cloneLead;
        
        
    
    /*
    trigger Customer_After_Insert on APEX_Customer__c (after update) {
	List InvoiceList = new List();
	for (APEX_Customer__c objCustomer: Trigger.new) {
		if (objCustomer.APEX_Customer_Status__c == 'Active') {
			APEX_Invoice__c objInvoice = new APEX_Invoice__c();
			objInvoice.APEX_Status__c = 'Pending';
			InvoiceList.add(objInvoice);
		}
	}
	//DML to insert the Invoice List in SFDC
	insert InvoiceList;
}
    
    
    */
    
    
    
    
    //insert cloneLead;
  /*  List<lead> e = [SELECT id,lastname,company,status,Email,phone from lead];
system.debug(e);
lead eCopy = e[1].clone(true, false, false, false);
ecopy.status='Working - Contacted';

ecopy.email='aghhgchcfd'+e[1].email;
ecopy.phone='aaaaaaaaaaaaaa'+e[1].phone;
system.debug(eCopy);
update eCopy;
*/
}