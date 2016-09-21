@isTest(seeAllData=false)
   private class TestForDeDupeChecK {

    
  
       
   static testMethod void TestForDeDupeCheckBeforeInsert()
   {
     List<Lead> leads = new List<Lead>();
        
        for(Integer i =100; i < 300; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            leads.add(l);
            
  	    }

        test.startTest();
        insert leads; 
        test.stopTest();
        
    
    //Test for single record 
       
       Lead ll =new Lead(email='102ajinkya@gmail.com',phone='102123456',lastname='ff',company='fff');
       
       try
       {
           insert ll;
           
       }
       catch(Exception e)
       {
           Boolean expectedExceptionThrown =  (e.getMessage().contains('Record with same eamil already Present')) ? true : false;
           System.AssertEquals(expectedExceptionThrown, true);
         
       } 
       
     //Test for records in Bulk  
      
       List<Lead> Bulkleads=new List<Lead>();
     
       for(Integer i =0; i <200; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            Bulkleads.add(l);
        }
       
       try
       {
           insert Bulkleads;
           
       }
       catch(Exception e)
       {
           Boolean expectedException =  (e.getMessage().contains('Record with same eamil already Present')) ? true : false;
           system.debug('E contains=' +e);
           System.AssertEquals(expectedException, true);
        
       }
  
       
   }
       
   	 static testMethod void TestForDeDupeCheckBeforeUpdate()
  	 {
       List<Lead> leads = new List<Lead>();
       
       for(Integer i = 0; i < 200; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            leads.add(l);
            
  	    }

        test.startTest();
        insert leads; 
        test.stopTest();
        
        
        //Test for single record
        //For possitive Input
         
         Lead l= [SELECT email,phone FROM Lead  WHERE Id IN:leads And email!=null And phone!=null limit 1];
         String  orignalemail=l.Email;
         String orignalphone=l.Phone;  
           
          l.email='updatedemail@gmail.com'; 
          l.Phone='989856455';  
          update l;
      	
   	     List<Lead> ul=new List<Lead>();
    	  ul= ([SELECT email,phone FROM Lead  WHERE Id IN:leads And email='updatedemail@gmail.com' And phone='989856455']);
		 System.assertEquals(ul.size(),1);
         
         
         
         
         
        //Test for single record
        //For negative Input
         
         Lead leadNeg= [SELECT email,phone FROM Lead  WHERE Id IN:leads And email='0ajinky@gmail.com' And phone='0123456' ];
         leadNeg.Phone='0123456';
         leadNeg.Email='0ajinky@gmail.com';
         
          try
       {
           update leadNeg;
           
       }
       catch(Exception e)
       {
           Boolean expectedExceptionThrown =  (e.getMessage().contains('Record with same eamil already Present')) ? true : false;
           System.AssertEquals(expectedExceptionThrown, true);
         
       } 
          
         //Test for Bulk Record 
        //For Negative Input
        List<Lead> updateLeadList=new List<Lead>();
        for(lead l5:[SELECT email,phone FROM Lead  WHERE Id IN:leads And email!=null And phone!=null])
        {
                  for(Integer i = 0; i < 200; i++)
            {
            
                l5.Email=i+'ajinky@gmail.com';
                l5.Phone=i+'123456';
                updateLeadList.add(l5);
            }
                
        }
         
            try
       {
           update  updateLeadList;
           
       }
       catch(Exception e)
       {
           Boolean expectedExceptionThrown =  (e.getMessage().contains('Record with same eamil already Present')) ? true : false;
           System.AssertEquals(expectedExceptionThrown, true);
         
       } 
         
      
     
         
         
         
       
   }  
 
       
    static testMethod void TestForDeDupeCheckTask()
    {
        List<Lead> Bulkleads=new List<Lead>();
        //create single lead and check for task
        Lead llead =new Lead(email='ajinkya@gmail.com',phone='23456',lastname='ff',company='dfff');
        insert llead;
        Task t= [select whoID from task limit 1];
        System.assertEquals(llead.Id,t.WhoId);
        
        //create multiple leads and check for task
        for(Integer i =0; i <200; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit');
            Bulkleads.add(l);
        }
        
        insert Bulkleads;
        
        Map<id,Task> tt =new Map<id,Task>();
       
         for(Task t1 : [select id,whoid from Task])
        {
            tt.put(t1.WhoId,t1);
        }
        
        
        for(Lead l2 : Bulkleads)
        {
            System.assertEquals(tt.containsKey(l2.Id),true);

        }
        
    }
       
       
       
   
      
             
       static testMethod void TestForDeDupeCheckLeadClone()
   {
    	Integer count=0;
       //Test for single record clone
        Lead cl =new Lead(email='ajinkyaclone@gmail.com',phone='111111111',lastname='ff',company='fff',Status='Open - Not Contacted');
        insert cl;
        List<Lead> alleads=new List<Lead>([select Status,email from Lead]);
 
       
       for(Lead l3:alleads)
       {
         if(l3.Status=='Working - Contacted')
         count++;
       }
       
       	System.assert(count==1);
        
       //Test for Bulk Records
      
       count=0;
       
       List<Lead> Bulkl=new List<Lead>();
     
        for(Integer i =500; i <700; i++)
        {
            Lead l = new Lead(Email=i+'ajinky@gmail.com',phone=i+'123456',lastname=i+'tata',company=i+'tatalmit',Status='Open - Not Contacted');
       		 Bulkl.add(l);
        }
       insert Bulkl;
       List<Lead> SelectedLeads=new List<Lead>([select Status,email from Lead where Status = 'Working - Contacted']);
    
         /*for(Lead l3:SelectedLeads)
       {
         if(l3.Status	==	'Working - Contacted')
         count++;
       }*/
       System.debug('Count'+count);
       //System.assert(count==201);
       System.assertEquals(Bulkl.size()+1,SelectedLeads.size()+1);

   }  
   
       
       
       
    
    
    
    
}