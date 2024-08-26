//RAD Part II Week 4 Homework
//Create a method that will be called before a recipe is inserted or updated to check if it is missing key values.  
//If it is missing one or more fields, check the Draft__c field on the recipe
//We also want to rate the complexity of a recipe.
//Calls out to a method on the HelperFunctions class called rateRecipeComplexity.
//Gets the numerical rating back from the method and use it to fill in the Complexity__c field.
//After a recipe is inserted or updated, if it’s not a draft recipe, and if it’s being used in any cookbooks, we want to create a review task.

public class RecipeHandler {
    //Trigger handler variables
    List<Recipe__c> newOrUpdatedRecipes;
    Map<Id, Recipe__c> oldRecipes;

    //constructor
    public RecipeHandler(List<Recipe__c> newTriggerRecipes, Map<Id, Recipe__c> oldMap){
        newOrUpdatedRecipes = newTriggerRecipes;
        oldRecipes = oldMap;
    }
    
	public void markDraft(){
        for (Recipe__c r : newOrUpdatedRecipes){
            if(r.Name == null || r.Active_Time__c == null || r.Description__c == null || r.Active_Time_Units__c == null || r.Servings__c == null){
               r.Draft__c = TRUE;}
        }
    }
    
	public void markComplexity(){        
        for (Recipe__c r : newOrUpdatedRecipes){
			Integer ratingValue = HelperFunctions.rateRecipeComplexity(r);
            if(ratingValue == 3){
                r.Complexity__c = 'Difficult';
            }
            else if(ratingValue == 2){
                r.Complexity__c = 'Moderate';
            }
            else {
                r.Complexity__c = 'Simple';
            }
		}
    }
    
    //after insert or update
    
    public void reviewTask(){
        //list of new review tasks to insert later
		List <Task> newReviewTasks = new List<Task>();
        //get the recipe usage for the recipe or recipes in the trigger and get all the related info needed to create the tasks
        //if the recipe is not a draft and if the recipe has a Usage record, indicating it is used in a cookbook
        for (Recipe_Usage__c recipeUsage : [SELECT Id, Name, Cookbook__c, Cookbook__r.Id, Cookbook__r.OwnerId, Cookbook__r.Name, Recipe__c, Recipe__r.Id, Recipe__r.Name, Recipe__r.Draft__c FROM Recipe_Usage__c WHERE Recipe__c IN (SELECT Id FROM Recipe__c WHERE Id IN : newOrUpdatedRecipes AND Draft__c = FALSE)]){     
        	//create a review task for each cookbook where this recipe appears	
            //assign task to the user who owns the cookbook and make the due date one week from when edit was made
            Task t = new Task();
        	t.WhatId = recipeUsage.Cookbook__r.Id;
            t.OwnerId = recipeUsage.Cookbook__r.OwnerId;
        	t.Status = 'Not Started';
            t.Subject = 'Review '+ recipeUsage.Recipe__r.Name + ' for Cookbook '+ recipeUsage.Cookbook__r.Name;
            t.ActivityDate = System.today() + 7;
            newReviewTasks.add(t);}
             
        //insert the list of new review tasks
        System.debug('Review Task List: '+newReviewTasks);   
        insert newReviewTasks;
	}
}
