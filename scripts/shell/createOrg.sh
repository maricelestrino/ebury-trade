#!/bin/sh
#set -x
echo "Creating your scratch org!"
sfdx force:org:create -f config/project-scratch-def.json -a mariScratchOrg --setdefaultusername
echo "Wait, now I'm deploying!"
sfdx force:source:push --forceoverwrite
echo "Executing some shortcuts"
sfdx force:apex:execute -f scripts/apex/updateQueue.apex
echo "Ok, now you can enjoy"
sfdx force:org:open --path lightning