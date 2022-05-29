public with sharing class PicklistUtils {

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