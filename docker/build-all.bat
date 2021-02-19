@echo off

set dir=%~dp0
set push=%~1

call single-build.bat nginx-netcore %push%
call single-build.bat nginx-netcore-libman %push%

docker build .. -t darakeon/server -f "%dir%server.dockerfile"

if "%push%" neq "" (
	docker %push% darakeon/server
)
