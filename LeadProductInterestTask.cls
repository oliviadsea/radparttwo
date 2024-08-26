//RAD Part II Week 3 Homework
public class LeadProductInterestTask {
    
    //after insert and update create a Task based on the Lead's Product Interest
    //after update only insert task if Product Interest has changed
    
    public static void handleAfterInsert(List<Lead> newLeads){
        
        //after insert create new tasks by Product Interst
        
   	 List<Task> newTasks = new List<Task>();
