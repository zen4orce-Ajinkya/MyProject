@isTest(seeAllData=false)
   private class TestForDeDupeChecK {

    
   private static List<Lead> leads = new List<Lead>{};
       
   static testMethod void TestForDeDupeCheckBeforeInsert()
   {
    
        
        for(Integer i = 0; i < 200; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            leads.add(l);
            
  	    }

    test.startTest();
    insert leads; 
    test.stopTest();
    
    
    //Test for single record
    Lead ll =new Lead(email='ajinkya@gmail.com',phone='23456',lastname='ff',company='fff');
    for(Lead l: [SELECT email,phone FROM Lead  WHERE Id IN:leads And email!=null And phone!=null]){
    
        System.assert(l.email+l.Phone!=ll.Email+ll.Phone);
    
    }
     
       
    //Test for records in Bulk   
       leads.clear();
       for(Integer i = 200; i < 400; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            leads.add(l);
        }
       insert leads;
      
       Map<String,Lead> ep=new Map<String,Lead>();
      
       for(Lead l: [SELECT email,phone FROM Lead  WHERE Id IN:leads And email!=null And phone!=null]){
             
        ep.put(l.Email+l.Phone,l);
        //System.assert(l.email+l.Phone!=ll.Email+ll.Phone);
    
       }
       for(lead l1 : leads)
       {
           System.assert(!ep.containsKey(ll.Email+ll.Phone));
            
       }
       
   }
    
    static testMethod void TestForDeDupeCheckTask()
    {
        //create single lead and cheak for task
        Lead llead =new Lead(email='ajinkya@gmail.com',phone='23456',lastname='ff',company='dfff');
        insert llead;
        task t= [select whoID from task];
        System.assertEquals(llead.Id,t.WhoId);
       
    }
       
       
       
     static testMethod void TestForDeDupeCheckBeforeUpdate()
   {
      
       for(Integer i = 0; i < 200; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            leads.add(l);
            
  	    }

    test.startTest();
    insert leads; 
    test.stopTest();
    
    
    //Test for single record
   // Lead ll =new Lead(email='ajinkya@gmail.com',phone='23456',lastname='ff',company='fff');
   	 Lead l= [SELECT email,phone FROM Lead  WHERE Id IN:leads And email!=null And phone!=null limit 1];
     String  orignalemail=l.Email;
     String orignalphone=l.Phone;  
       
      l.email='updatedemail@gmail.com'; 
      l.Phone='989856455';  
      update l;
        
      System.assert(l.email+l.Phone!=orignalemail+orignalphone);
   
   }  
       
    
    
    
    
}