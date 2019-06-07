Write-Host -foregroundcolor Yellow "Removing Unncessary Windows 10 Default Software"
"`n"
Write-Host -ForegroundColor Yellow "Press Enter ONLY when removal is completed."
            "-----------------------------------------"

Write-Host -ForegroundColor Yellow "Removing 3D Builder" "`n"
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Windows Calendar and Mail" "`n"
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Windows Camera" "`n"
Get-AppxPackage *windowscamera* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Office Hub" "`n"
Get-AppxPackage *officehub* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Skype" "`n"
Get-AppxPackage *skypeapp* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Get Started" "`n"
Get-AppxPackage *getstarted* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Windows Maps" "`n"
Get-AppxPackage *windowsmaps* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Solitaire Collection" "`n"
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Bing Finance" "`n"
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Zune Video" "`n"
Get-AppxPackage *zunevideo* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Bing News" "`n"
Get-AppxPackage *bingnews* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Built-In One Note" "`n"
Get-AppxPackage *onenote* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing People App" "`n"
Get-AppxPackage *people* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Windows Phone App" "`n"
Get-AppxPackage *windowsphone* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Bing Sports" "`n"
Get-AppxPackage *bingsports* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Sound Recorder" "`n"
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Bing Weather" "`n"
Get-AppxPackage *bingweather* | Remove-AppxPackage
Write-Host -ForegroundColor Yellow "Removing Xbox App" "`n"
Get-AppxPackage *xboxapp* | Remove-AppxPackage


"`n"
Write-Host -ForegroundColor Yellow "Setting Up the Start Menu"
            "-----------------------------------------"
            Import-StartLayout -LayoutPath "C:\installSoftware\startLayout.bin" -MountPath $env:SystemDrive\ -verbose

Write-Host -ForegroundColor yellow "This computer should be complete now. Please confirm."
Write-Host -ForegroundColor Yellow "Press any key to close this program."


exit


