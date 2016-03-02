@echo off

REM A script to recurse a DOS directory and perform
REM a single command on the files it finds

set SEARCHTERM="secret"
set SCANDIR="E:\live-digital-transfers-working\..."

echo %SCANDIR%

REM Generate a unique string to attach to file

setlocal enabledelayedexpansion

ECHO Start Measure - !!!SEARCHTERM!!!: %Time% >> timer-grep-!!!SEARCHTERM!!!.txt

	FOR /R %SCANDIR% %%F IN (*.*) DO (	
		java -jar tika-app-1.12.jar -t "%%F" | grep -m 1 !!!SEARCHTERM!!! > tmpfile
      set /p myvar= < tmpfile
      echo Path: "%%F","!!!myvar!!!" | grep -m 1 !!!SEARCHTERM!!!
      set "myvar="
      del tmpfile
	)

ECHO Stop Measure - !!!SEARCHTERM!!!: %Time% >> timer-grep-!!!SEARCHTERM!!!.txt

endlocal
