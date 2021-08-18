@echo off

set dir=%~dp0
set machine=%~1
set context=%2
set push=%~3

if "%context%" == "" (
	set context=.
)

docker build %context% --pull -f %dir%../images/%machine%.dockerfile -t darakeon/%machine% --network=host

if "%push%" == "push" (
	docker push darakeon/%machine%
)
