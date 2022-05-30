List<User> users = [Select Id from User where Profile.Name = 'System Administrator'];
Group queue = [Select Id from Group Where name = 'Trade reviewers'];
List<GroupMember> groupMembers = new List<GroupMember>();
for(User user : users){
    GroupMember groupMember = new GroupMember();
    groupMember.GroupId = queue.Id;
    groupMember.UserOrGroupId = user.Id;

    groupMembers.add(groupMember);
}
insert groupMembers;