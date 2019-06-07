# PostImageScript
The post image script I've developed for my current company

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
	
	