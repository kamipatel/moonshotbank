#!/bin/bash

sfdx force:org:create -s -f config/project-scratch-def.json -a ADK --setdefaultusername -d 10
sfdx force:source:push 
sfdx force:user:permset:assign -n BankPerms
sfdx force:data:bulk:upsert -s Account -f data/Churn.csv -w 5 -i extId__c
sfdx force:data:tree:import -f data/export-demo-Recommendations.json
sfdx force:apex:execute -f config/create-demo-data-setup.apex
sfdx force:org:open


