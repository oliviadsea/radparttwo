//RAD Part II Week 3 Homework
public class LeadProductInterestTask {
    
    //after insert and update create a Task based on the Lead's Product Interest
    //after update only insert task if Product Interest has changed
    
    public static void handleAfterInsert(List<Lead> newLeads){
        
        //after insert create new tasks by Product Interst
        
   	 List<Task> newTasks = new List<Task>();
        //loop through new leads and set task variables then add them to the new tasks list
    	for (Lead l : newLeads) {
		////instantiate the new task to be inserted with base values
        Task t = new Task();
         t.WhoId = l.Id;
       	 t.Status = 'Not started';
         t.ActivityDate = System.today();
        //populate variables for the new task    
        if(l.ProductInterest__c == 'Cookbook Authorship'){
            t.Subject = 'Follow up about ' + l.ProductInterest__c;
            t.Priority = 'High';}
        else if (l.ProductInterest__c == 'Cookbook Editing'){
            t.Subject = 'Follow up about ' + l.ProductInterest__c;
            t.Priority = 'Normal';}
        else if (l.ProductInterest__c == 'Cookbook Illustration'){
            t.Subject = 'Follow up about ' + l.ProductInterest__c;
            t.Priority = 'Normal';
         } 
            newTasks.add(t);
    }
insert newTasks;
}

public static void handleAfterUpdate(Map<Id,Lead> newMap, Map<Id,Lead> oldMap){
    //container for the new tasks
    List<Task> newTasksExistingLead = new List<Task>();
    //loop over the lead from the trigger with the new Product Interest value
    for (Lead lead : newMap.values()){
        //instantiate the new task to be inserted with base values
        Task t = new Task();
        	t.WhoId = lead.Id;
        	t.Status = 'Not started';
        	t.ActivityDate = System.today();
        //compare the old value of Product Interest to the new value of Product Interest
        if(oldMap.get(lead.Id).ProductInterest__c != newMap.get(lead.Id).ProductInterest__c){
        //populate the tasks just like above       
        if(lead.ProductInterest__c == 'Cookbook Authorship'){
            t.Subject = 'Follow up about ' + lead.ProductInterest__c;
            t.Priority = 'High';
       }
        else if (lead.ProductInterest__c == 'Cookbook Editing'){
            t.Subject = 'Follow up about ' + lead.ProductInterest__c;
            t.Priority = 'Normal';
		} 
         else if (lead.ProductInterest__c == 'Cookbook Illustration'){
            t.Subject = 'Follow up about ' + lead.ProductInterest__c;
            t.Priority = 'Normal';
         } 
            newTasksExistingLead.add(t);
    }
        //check that there are tasks to insert so we don't insert an empty list if the Product Interest didn't change
        if(newTasksExistingLead.size() > 0){
            insert newTasksExistingLead;} 
        }
    }
}
@oliviadsea
Comment
 
Leave a comment
 
Footer
© 2024 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact
Manage cookies
Do not share my personal information
RAD Part II Week 3 Homework 
