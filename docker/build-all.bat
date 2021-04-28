@echo off

set push=%~1

call single-build.bat ubuntu . %push%
call single-build.bat netcore . %push%
call single-build.bat server .. %push%
