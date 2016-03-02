@echo off

REM A script to recurse a DOS directory and perform
REM a single command on the files it finds
REM uses tika to find instances of word "draft"
REM repaced by search-term-batch-script

set SCANDIR="E:\live-digital-transfers-working\..."

echo %SCANDIR%

setlocal enabledelayedexpansion

	SET /A COUNT=0

	FOR /R %SCANDIR% %%F IN (*.*) DO (	
		java -jar tika-app-1.6.jar -t "%%F" | grep -m 1 "draft" > tmpfile
      set /p myvar= < tmpfile
      echo Path: "%%F","!!!myvar!!!" | grep -m 1 "draft"
      echo.
      set "myvar="
      del tmpfile
	)

endlocal
