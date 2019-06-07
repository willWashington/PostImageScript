goto comment

**********************COMPANYNAME INSTALL SOFTWARE SCRIPT NOTES**********************
	>3.22.18< Author: William Washington
This is the post script for COMPANYNAMEnancial computers. It installs all software
that a machine should need that the image does not cover.

The functionality of this script should be noted well. The logic can easily
be looked up online and reverse engineered.

We are in the process of trying to get parts of this script moved
in to the image itself so that these softwares are installed when the pc
is initially scripted.

Logic Notes:
pings are timers. 6000 is 6 seconds. 12000 is 12 seconds, etc.

To Edit:
This script pulls software from the repository I have built in the following
directory:
\\COMPANYNAME\files\software\COMPANYNAME_scripts\software

To get software to work silently, you have to do a little research:
	Find the installer for the software you want to install (MSI is always better than exe)
	Copy the installer to a folder on your machine
	Open CMD
	Copy the path of the executable and add the file name on the end into the CMD window
		IE: Move chrome64.msi to c:\installFolder
		Open CMD
		Type c:\installFolder\chrome64.msi (or .exe)
	At this point, you have to figure out the parameters to make a software run silently.
	Most MSI files can take a /q switch which will make them install silently
		(hence why .msi is better than .exe)
	EXE files are harder. You have to use the above command and try to figure out the correct
	switch to get information about the installer.
	Like this:
		c:\installFolder\chrome64.exe -?
		c:\installFolder\chrome64.exe -help
		c:\installFolder\chrome64.exe /?
		c:\installFolder\chrome64.exe /help
		c:\installFolder\chrome64.exe --help
		c:\installFolder\chrome64.exe --?
	One of these should give you a popup that will tell you what parameters you can use with it.
	
	These are not always correct.
	For instance, if you run this against the RightFax setup.exe, it will tell you you can use
	/quiet and it will work. That is not the case.
	You have to use /unattended=true
	So you have to research these solutions on Google some, too.
	
	Ultimately, if you place the software's .exe or .msi in the software repository, you can copy 
	the install lines from my script and figure out the needed switches to make them install silently.
	
	
:comment


echo ----- THIS SCRIPT WILL INSTALL SOFTWARE SILENTLY WHEN YOU PROCEED PAST THIS LINE. 
echo ----- PLEASE BE SURE YOU WANT TO INSTALL SOFTWARE BEFORE CONTINUING. 
echo ************************************************************************


echo Enter a Computer Description and Press Enter.
set /P cpdesc=
	net config server /srvcomment:"%cpdesc%"
set cpdesc=


REM install Citrix
REM echo ----- INSTALLING CITRIX
	REM "\\COMPANYNAME\files\Software\Citrix Receiver\Citrix Reciever 4.11\citrixreceiver.exe" /silent
REM ping 1.1.1.1 -n 1 -w 12000>NUL
REM install Printer Installer
REM ECHO ----- INSTALLING PRINTER INSTALLER
	REM "\\COMPANYNAME\files\Software\Printer Installer Client\printerinstallerclient.msi" -quiet
REM ping 1.1.1.1 -n 1 -w 12000>NUL
REM install Chrome
REM ECHO ----- INSTALLING CHROME
REM msiexec.exe /q /I "\\EDSTORE\Software\Google Chrome Install\googlechromestandaloneenterprise.msi"
REM ping 1.1.1.1 -n 1 -w 12000>NUL
REM ECHO ----- INSTALLING GOVERLAN CERTIFICATE
REM install Goverlan Certificate
certutil.exe -addstore trustedpublisher "\\COMPANYNAME\files\Software\GoverLAN\govcert.cer"
REM ping 1.1.1.1 -n 1 -w 12000>NUL
REM ECHO ----- INSTALLING GOVERLAN SMART CARD DRIVER
REM install Goverlan Smart Card Driver
"\\COMPANYNAME\files\Software\GoverLAN\SmartCardDriver\SmartCardDriver\govsmartcarddriver.exe" /S /v/qn
REM ping 1.1.1.1 -n 1 -w 12000>NUL 
REM ECHO ----- INSTALLING GOVERLAN CLIENT 
msiexec.exe /q /I "\\COMPANYNAME\files\software\goverlan\govreachclient64.msi"
REM ping 1.1.1.1 -n 1 -w 12000>NUL 

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


 ask for user input laptop
 :ask1
 set /P c=Is this a Laptop? (y/n): %=%
 if /I "%c%" EQU "y" GOTO :yes1
 if /I "%c%" EQU "Y" GOTO :yes1
 if /I "%c%" EQU "n" GOTO :ask
 if /I "%c%" EQU "N" GOTO :ask
 GOTO :ask1

 if user replies yes, install AnyConnect
 :yes1
 ECHO ----- INSTALLING ANYCONNECT
	 "\\COMPANYNAME\files\software\COMPANYNAME_scripts\software\anyconnect.exe" /quiet /norestart
	 msiexec.exe /i "\\EDSTORE\Software\Cisco AnyConnect\anyconnect-win-4.6.01103-core-vpn-predeploy-k9.msi" /q
 ping 1.1.1.1 -n 1 -w 12000>NUL
 GOTO :ask

 ask for user input CRD
 :ask
 set /P c=Is this a CRD Machine? (y/n): %=%
 if /I "%c%" EQU "y" GOTO :yes
 if /I "%c%" EQU "Y" GOTO :yes
 if /I "%c%" EQU "n" GOTO :end
 if /I "%c%" EQU "N" GOTO :end
 if user enters anything other than y or n, return to question
 GOTO :ask

:yes
 set SLSS to compatibility mode with reg file
 echo ----- SETTING COMPAT MODE FOR SLSS
 	regedit.exe /S "c:\installSoftware\slssReg.reg"
 install Passport
 ECHO ----- PURGING CURRENT SLSS SHORTCUTS
	del "C:\Users\Public\Desktop\SLSS - Additional.lnk"
	del "C:\Users\Public\Desktop\SLSS - Primary.lnk"
	del "C:\Users\Public\Desktop\SLSS - Commercial.lnk"
	del "C:\Users\Public\Desktop\SLSS - Com Additional.lnk"
	del "C:\Users\Public\Desktop\SLSS - Additional.zws"
	del "C:\Users\Public\Desktop\SLSS - Primary.zws"
	del "C:\Users\Public\Desktop\SLSS - Commercial.zws"
	del "C:\Users\Public\Desktop\SLSS - Com Additional.zws"
 ECHO ----- INSTALLING PASSPORT AND APPLYING LICENSE
	msiexec.exe /i "\\COMPANYNAME\files\Software\Passport\Passport 21.1.1\pc2host64\passport.msi" /qn ALLUSERS=1 LICENSE="xxxxxxxxxxxxxxxxx"
 ECHO ----- COPYING SESSIONS
	xcopy "\\COMPANYNAME\files\Software\Passport\Sessions" "C:\Program Files\Passport\Sessions" /I /Y /E
	xcopy "C:\Program Files\Passport\Sessions\shortcuts\SLSS - Additional.lnk" "C:\Users\Public\Desktop" /I /Y
	xcopy "C:\Program Files\Passport\Sessions\shortcuts\SLSS - Commercial.lnk" "C:\Users\Public\Desktop" /I /Y
	xcopy "C:\Program Files\Passport\Sessions\shortcuts\SLSS - Com Additional.lnk" "C:\Users\Public\Desktop" /I /Y
	xcopy "C:\Program Files\Passport\Sessions\shortcuts\SLSS - Primary.lnk" "C:\Users\Public\Desktop" /I /Y

 ping 1.1.1.1 -n 1 -w 12000>NUL
 ECHO ----- INSTALLING ATLAS PLUGIN
 	msiexec /q /I "\\COMPANYNAME\files\Software\COMPANYNAME_Scripts\software\Atlas\atlas_msi.msi"
goto :end



:end
REM ECHO ----- KILLING INSTALLER
REM	taskkill /im msiexec.exe /f
REM	ping 1.1.1.1 -n 1 -w 6000>NUL
 install RightFax
"\\COMPANYNAME\files\Software\RightFax\Prereqs\vs2012_vcredist_x86.exe" /quiet /norestart
msiexec.exe /i "\\COMPANYNAME\files\Software\RightFax\Client\RightFax Product Suite - Client.msi" /qn REBOOT=ReallySuppress RUNBYRIGHTFAXSETUP=2 CONFIGUREFAXCTRL=1 CONFIGUREFAXUTIL=1 ADDLOCAL="FaxUtil,FaxCtrl"  RFSERVERNAME="SERVER"
REM "\\COMPANYNAME\files\Software\Java\8.181\JavaSetup8u181.exe" /s
exit