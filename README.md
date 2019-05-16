sfdx force:auth:web:login -d -a devhub

sfdx force:org:create -s -f config/project-scratch-def.json -a so

sfdx force:source:push -f

sfdx force:user:permset:assign -n BankPerms

sfdx force:data:bulk:upsert -s Account -f ~/demos/Einstein/data/Churn.csv -i extId\_\_c -w 5

## TODO Import Account and Recommendation data

sfdx force:org:open

#sfdx force:org:create -f config/project-scratch-def.json -d 30 -a so

#sfdx force:user:password:generate --targetusername test-hllpmfveashp@example.com

#sfdx force:source:push -u so -f

#sfdx force:user:permset:assign -n BankPerms -u so

sfdx force:data:bulk:upsert -s Account -f ~/demos/Einstein/data/Churn.csv -i extId\_\_c -u so -w 5

sfdx force:user:password:generate --targetusername test-wwop9yhnbihw@example.com

sfdx force:org:open -u so

sfdx force:source:pull -u so

sfdx analytics:app:list -u so
sfdx analytics:template:list -u so

sfdx analytics:template:create -f 00l0n000000I71EAAS -u so
sfdx analytics:app:create -t 0Nk9A0000008ORNSA2 -u so

sfdx analytics:template:update -t 0Nk4F0000008OIASA2 -u so

sfdx analytics:app:delete -p -f 00l1k000000M52QAAS -u so

sfdx analytics:template:delete -t 0Nk2f0000004C93CAE -u so

sfdx force:auth:web:login -d -a so
sfdx force:package:create -n MoonShotBankPkg -d "MoonShotBankPkg to demo ED with NBA" -r force-app -t Unlocked -v so
sfdx force:package:version:create -p MoonShotBankPkg -d force-app -k test1234 --wait 10 -v so

sfdx force:user:permset:assign --permsetname BankFieldAccess --targetusername <admin-user>
