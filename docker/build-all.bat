@echo off

set push=%~1

single-build.bat nginx %push%
single-build.bat nginx-netcore %push%
single-build.bat nginx-netcore-libman %push%
