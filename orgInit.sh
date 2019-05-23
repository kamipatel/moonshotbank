#!/bin/bash

sfdx force:org:create -s -f config/project-scratch-def.json -a ADK --setdefaultusername -d 10
sfdx force:source:push -f
sfdx force:apex:execute -f config/create-demo-data-setup.apex
sfdx force:user:permset:assign -n BankPerms
sfdx force:data:tree:import -f data/export-demo-Recommendations.json
sfdx force:data:bulk:upsert -s Account -f data/cust.csv -i extId__c --json
sfdx force:org:open


