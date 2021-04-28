@echo off

set dir=%~dp0
set machine=%~1
set context=%2
set push=%~3

docker build %context% -f %machine%.dockerfile -t darakeon/%machine% --network=host

if "%push%" == "push" (
	docker push darakeon/%machine%
)
