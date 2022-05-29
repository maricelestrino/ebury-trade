public with sharing class GroupMemberSelector {

    public static Set<Id> getAllMemberIdsByQueueName(String groupName){
        List<GroupMember> groupMembers = [Select UserOrGroupId from GroupMember Where Group.Name = : groupName];
        Set<Id> groupMemberIds = new Set<Id>();
        for(GroupMember groupMember : groupMembers){
            groupMemberIds.add(groupMember.UserOrGroupId);
        }
        return groupMemberIds;
    }    
}