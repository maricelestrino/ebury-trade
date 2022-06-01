public with sharing class PicklistUtils {

    //get all picklist values as string list using the object and the SObject field as parameter
    public static List<String> getPicklistValuesList(SObjectType sObjectType, Schema.sObjectField field){

        List<String> pickListValuesList= new List<String>();

        Schema.DescribeFieldResult fieldResult = field.getDescribe();
		List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();

		for(Schema.PicklistEntry pickListEntry : picklistEntries){
			pickListValuesList.add(pickListEntry.getLabel());
		}
        return pickListValuesList;
    }
}