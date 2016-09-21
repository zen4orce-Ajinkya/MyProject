trigger fdf on Opportunity (after insert,after update) {
    
    List<task> tlist =new List<task>();
    
    for(Opportunity op:[select id,stagename from Opportunity where stagename='closed won' AND id IN :Trigger.new])
    {
        tlist.add(new task(subject='Follow Up Test Task',whatid=op.id));
    }

}