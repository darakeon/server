@echo off

set push=%~1

call single.bat ubuntu . %push%
call single.bat netcore . %push%
call single.bat server ../.. %push%

call single.bat talisman . %push%

REM call single.bat aws . %push%
REM call single.bat aws-terraform . %push%
