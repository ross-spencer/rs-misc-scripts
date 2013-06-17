@echo off 

REM A script to recurse a DOS directory and perform
REM a single command on the files it finds

set SCANDIR="C:\Working\nlnz-test-files\"
set OUTDIR="C:\Working\tika-out\"

FOR /R %SCANDIR% %%F IN (*.*) DO (
  setlocal enabledelayedexpansion
	set FILENAME="%OUTDIR%%%~nF.tika"
	echo Path: %%F > !!FILENAME!!
	java -jar tika-app-1.3.jar -m %%F >> !!FILENAME!!
	echo Result output to !!FILENAME!!
	endlocal
)
