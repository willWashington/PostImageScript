
REM start COMPANYNAME Default UI Experience Section
echo ----- SETTING DEFAULT UI
REM copy the Default App XML file to local machine
	copy "%~dp0/defApp.xml" "c:\"
	copy "%~dp0/startLayout.bin" "c:\"
REM import Default App Associations from XML
echo ----- SETTING DEFAULT UI
	Dism.exe /Online /Import-DefaultAppAssociations:C:\defApp.xml
REM run Powershell script to remove unneccessary Win10 stock apps and set UI Customization
echo ----- REMOVING DEFAULT WINDOWS 10 APPS
	powershell.exe -noprofile -ExecutionPolicy Bypass -command "&{ start-process powershell  -ArgumentList '-noprofile -file c:\installSoftware\installSoftware.ps1' -verb RunAs}"