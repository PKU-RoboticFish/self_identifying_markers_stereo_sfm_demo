set PROC_HOME=%~dp0
Forfiles /p ..\registration_image\ /s /m *.jpg /c "cmd /c cd %PROC_HOME% && .\CheckboardLocalizationNoDisplay.exe @path"
pause
