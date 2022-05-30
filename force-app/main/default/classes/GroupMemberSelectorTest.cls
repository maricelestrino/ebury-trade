@IsTest
public with sharing class GroupMemberSelectorTest {
    
    @IsTest
    public static void getAllMemberIdsByQueueName_shouldReturnRecord() {
        
        User user = TestDataFactory.createUserAdmin();
        insert user;

        Group queue = TestDataFactory.createQueue('Trade reviewers');
        insert queue;

        GroupMember groupMember = TestDataFactory.createGroupMember(user.Id, queue.Id);
        insert groupMember;

        Set<Id> retrievedGroupMember = GroupMemberSelector.getAllMemberIdsByQueueName('Trade reviewers');

        System.assertEquals(true, retrievedGroupMember.size() > 0, 'should retrieve some record');
    }
}
