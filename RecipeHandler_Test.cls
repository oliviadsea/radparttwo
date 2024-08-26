//RAD Part II Week 5
//positive tests for methods in RecipeHandler class
@isTest
public class RecipeHandler_Test {
    
    @isTest
    	static void testMarkDraft(){

        // create recipe
        Recipe__c rec = new Recipe__c();
        rec.Name = 'Test Recipe 1';
        rec.Description__c = 'This is an incomplete draft recipe.';
        insert rec;
    
	// load the rec record and assert that Draft is TRUE
	// third parameter of the assert statement is what will show up when the test fails 
       	rec = [SELECT Draft__c FROM Recipe__c WHERE Id = : rec.Id];
    
       System.assertEquals(TRUE, rec.Draft__c, 'This recipe should be marked as draft');
    }
    @isTest
    static void testMarkComplexity(){
        
        // create recipe
        Recipe__c rec = new Recipe__c();
        rec.Name = 'Test Recipe 2';
        rec.Description__c = 'This is a difficult recipe.';
        rec.Active_Time__c = 120;
        rec.Active_Time_Units__c = 'Minutes';
        insert rec;
        
        // load the rec record and assert that Complexity is Difficult based on the values set above
	// third parameter of the assert statement is what will show up when the test fails    
       	rec = [SELECT Complexity__c FROM Recipe__c WHERE Id = : rec.Id];
    
       System.assertEquals('Difficult', rec.Complexity__c, 'Recipe should be marked as difficult');
    }
    
    @isTest
    static void testReviewTask(){
        
        // create recipe
        Recipe__c rec = new Recipe__c();
        rec.Name = 'Test Recipe 3';
        rec.Description__c = 'This recipe is used in a cookbook';
        rec.Active_Time__c = 60;
        rec.Active_Time_Units__c = 'Minutes';
        rec.Servings__c = 24;
        insert rec;
        
        //create cookbook
        Cookbook__c cb = new Cookbook__c();
        cb.Name = 'Test Cookbook';
        insert cb;
        
        //create a usage to link them
        Recipe_Usage__c ru = new Recipe_Usage__c();
        ru.Recipe__c = rec.Id;
        ru.Cookbook__c = cb.Id;
        insert ru;
        
	//make an update to the recipe since the insert trigger ran before the usage record existed so we need it to run on update to create the task
        rec.Duration__c = 'Quick';
        update rec;
        
	//fetch the task list from the cookbook
        List<Task> taskList = new List<Task> ([SELECT Id FROM Task WHERE WhatId = : cb.Id]);
        
	//assert that the list contains one task
        System.assert(taskList.size() == 1);
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
