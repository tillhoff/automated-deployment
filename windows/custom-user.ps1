# explorer settings
## show file extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HidefileExt' -Value 0
## show all icons in traybar
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Value 0
## remove search field from taskbar
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value 0
## pin explorer ribbon
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' -Name 'MinimizedStateTabletModeOff' -Value 0
## set explorer to open 'This PC' by default instead of 'Quick access'
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1
###   1 == This PC
###   2 == Quick access
###   3 == Downloads
## set explorer to always show full path
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'CabinetState' -Value 1
###   0 == display name
###   1 == display full path
## set explorer to never show recently used files in quick access
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Value 0
## set explorer to never show frequently used files in quick access
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Value 0
## delete history of recently and frequently used files
Remove-Item -recurse -force $env:APPDATA/Microsoft/Windows/Recent/*
## restart explorer afterwards
#taskkill /IM explorer.exe /F; explorer.exe # killing explorer while files are written (logfile) is not a good idea. Instead:
Set-Variable -Name restartrequired -Value $true -Scope Global # setting variable globally
## expand explorer ribbon
#Set-ItemProperty -Path 'HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' -Name 'MinimizedStateTabletModeOff' -Value 0

# theme settings
## switch to darkmode
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Value 0
## disable transparency
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'EnableTransparency' -Value 0
## set accent color on start, taskbar and action center
#Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'ColorPrevalence' -Value 1
## set accent color on title bars
#Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\DWM' -Name 'ColorPrevalence' -Value 1
## delete background image history
#for ($i = 0; $i -le 5; $i++)
#{
#  if (Test-RegistryValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -value "BackgroundHistoryPath$i" )
#  {
#    Remove-ItemProperty -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -name "BackgroundHistoryPath$i" 
#  }
#}
## change background image
Copy-Item $PSScriptRoot/files/black.jpg C:/Users/$env:UserName/Pictures/black.jpg
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop' -name wallpaper -value C:/Users/$env:UserName/Pictures/black.jpg
Set-Variable -Name restartrequired -Value $true -Scope Global # setting variable globally

# user-specific windows settings
## disable cortana icon in task-bar
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowCortanaButton' -Value 0
## disable onedrive ads
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Value 0
## remove everything from (public & user) desktop
Remove-Item $HOME\Desktop\*.lnk -force
#Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' #recycle bin
## clear taskbar (only explorer remains)
reg import ./windows/files/cleantaskbar.reg
## add shortcuts to taskbar:
#%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\... -> OneNote, Outlook, but not ms-task, chrome
## copy netspeedmonitor-installer to desktop
Copy-Item $PSScriptRoot/files/netspeedmonitor.msi ~/Desktop/netspeedmonitor.msi

# user-specific putty settings
New-Item -Path HKCU:\SOFTWARE -Name SimonTatham
New-Item -Path HKCU:\SOFTWARE\SimonTatham -Name PuTTY
New-Item -Path HKCU:\SOFTWARE\SimonTatham\PuTTY -Name Sessions
New-Item -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions -Name alpha-centauri
New-ItemProperty -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\alpha-centauri -name HostName -value 78.46.161.35
New-ItemProperty -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\alpha-centauri -name UserName -value enforge
New-ItemProperty -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\alpha-centauri -name PublicKeyFile -value C:\Users\TillHoffmann\.ssh\till.hoffmann@enforge.de.ppk

Write-Host "Finished custom-user.ps1"