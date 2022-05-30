#!/bin/bash
if [ -z "$secrets.DEV_HUB_URL" ]; then
  echo "set default devhub user"
  execute sfdx force:config:set defaultdevhubusername=$DEV_HUB_ALIAS
fi

echo "Creating scratch org"
sfdx force:org:create -a $SCRATCH_ORG_ALIAS -s -f config/project-scratch-def.json -d 7 --setdefaultusername

echo "Pushing changes to scratch org"
sfdx force:source:push

echo "Make sure Org user is english"
sfdx force:data:record:update -s User -w "Name='User User'" -v "Languagelocalekey=en_US"

echo "Run setup code"
sfdx force:apex:execute -f scripts/apex/updateQueue.apex

echo "Ok, now you can enjoy"
sfdx force:org:open --path lightning