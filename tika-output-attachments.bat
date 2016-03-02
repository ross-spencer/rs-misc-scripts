@echo off

REM A script to recurse a DOS directory and perform
REM a single command on the files it finds
REM output file attachments to folder and clear up empties

set SCANDIR="E:\live-digital-transfers-working\..."
set EXTRACTDIR="extracts"

echo %SCANDIR%

REM Generate a unique string to attach to file

setlocal enabledelayedexpansion

	FOR /R %SCANDIR% %%F IN (*.*) DO (	
      echo Path: "%%F
      mkdir "extracts\%%~nxF"
      java -jar tika-app-1.12-2.jar -z --extract-dir="extracts\%%~nxF" "%%F"
	)
   
   REM delete only empty folders once process is complete
   REM "https://blogs.msdn.microsoft.com/oldnewthing/20080417-00/?p=22703"
   for /f "usebackq delims=" %%d in (`"dir "%EXTRACTDIR%" /ad/b/s | sort /R"`) do (
      rd "%%d"
   )
   
endlocal
