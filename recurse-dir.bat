@echo off 

REM A script to recurse a DOS directory and perform
REM a single command on the files it finds

set SCANDIR="C:\Working\nlnz-test-files\"
set OUTDIR="C:\Working\tika-out\"

REM Generate a unique string to attach to file

setlocal enabledelayedexpansion

	REM Count to append to timestamp
	SET /A COUNT=0
	
	REM Generate a timestamp #setlocal not working for !UNIQUE!
	REM http://www.dostips.com/DtCodeSnippets.php#Snippets.UniqueString
	FOR /f "tokens=2-8 delims=/:. " %%A IN ("%date%:%time: =0%") DO SET UNIQUE="%%C%%A%%B%%D%%E%%G%"

	FOR /R %SCANDIR% %%F IN (*.*) DO (	
		set /A COUNT+=1
		set FILENAME="%OUTDIR%!UNIQUE!-!COUNT!-%%~nF.tika"
		echo !!UNIQUE!!
		echo Path: %%F > !!FILENAME!!
		java -jar tika-app-1.3.jar -m %%F >> !!FILENAME!!
		echo Result output to !!FILENAME!!
	)
	
endlocal
