alias dxcreate = 'sfdx force:org:create -f config/project-scratch-def.json -a mariScratchOrg --setdefaultusername '
alias dxdeploy = 'sfdx force:source:push --forceoverwrite'
alias dxexecute = 'sfdx force:apex:execute -f scripts/apex/updateQueue.apex'
alias dxopen = 'sfdx force:org:open --path lightning'

dxStart () {
   sfcreate $1
   sfpush $1
   sfexecute $1
   sfopen $1
}