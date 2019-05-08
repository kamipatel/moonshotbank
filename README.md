sfdx force:auth:web:login --setdefaultdevhubusername

sfdx force:org:create -f config/project-scratch-def.json -d 30 -a so

sfdx force:user:password:generate --targetusername

sfdx force:source:push -u so

sfdx force:org:open -u so

sfdx force:source:pull -u so

sfdx analytics:app:list -u so
sfdx analytics:template:list -u so

sfdx analytics:template:create -f 00l0n000000I71EAAS -u so
sfdx analytics:app:create -t 0Nk9A0000008ORNSA2 -u so

sfdx analytics:template:update -t 0Nk210000004C9NCAU -u so

sfdx analytics:app:delete -p -f 00l2f000000M5TyAAK -u so

sfdx analytics:template:delete -t 0Nk2f0000004C93CAE -u so
