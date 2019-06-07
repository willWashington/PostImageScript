cscript.exe "\\COMPANYNAME\files\Software\iAccess\iAccessInstall\IBMiAccess_v1r1 (v1.1.6.2 Build 7031)\Windows_Application\install_acs_64_allusers.js"
ping 1.1.1.1 -n 1 -w 25000>NUL
xcopy "\\COMPANYNAME\files\Software\iAccess\iAccessInstall\IBM" "c:\users\public\IBM" /H /S /E /I /Y
ping 1.1.1.1 -n 1 -w 15000>NUL
del /q /s "C:\Users\Public\Desktop\ACS Session Mgr.lnk"
ren "C:\Users\Public\Desktop\Access Client Solutions.lnk" "iNavigator.lnk"
ping 1.1.1.1 -n 1 -w 5000>NUL
exit