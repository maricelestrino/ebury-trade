List<User> users = [Select Id from User where Profile.Name = 'System Administrator'];
for(User user : user){
    GroupMember groupMember = new GroupMember();
    groupMember.GroupId = queue.Id;
    groupMember.UserOrGroupId = user.Id;

    groupMembers.add(groupMember);
}
insert groupMembers;