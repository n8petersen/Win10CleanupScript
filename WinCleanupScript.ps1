﻿$Remove = (
    ("Microsoft.Microsoft3DViewer", "3D Viewer"),
    ("Microsoft.WindowsAlarms", "Alarms"),
    ("Microsoft.549981C3F5F10", "Cortana"),
    ("Microsoft.WindowsFeedbackHub", "Feedback Hub"),
    ("Microsoft.GetHelp", "Get Help"),
    ("Microsoft.ZuneMusic", "Groove Music"),
    ("microsoft.windowscommunicationsapps", "Mail & Calendar"),
    ("Microsoft.WindowsMaps", "Maps"),
    ("Microsoft.MicrosoftSolitaireCollection", "SolitaireCollection"),
    ("Microsoft.MixedReality.Portal", "Mixed Reality Portal"),
    ("Microsoft.ZuneVideo", "Movies & TV"),
    ("Microsoft.MicrosoftOfficeHub", "Office"),
    ("Microsoft.Office.OneNote", "OneNote"),
    ("Microsoft.MSPaint", "Paint 3D"),
    ("Microsoft.People", "People"),
    ("Microsoft.YourPhone", "Phone Link"),
    ("Microsoft.SkypeApp", "Skype"),
    ("Microsoft.Getstarted", "Tips"),
    ("Microsoft.WindowsSoundRecorder", "Voice Recorder"),
    ("Microsoft.BingWeather", "Weather")
)

$Optional = (
    # ("Microsoft.WindowsStore", "Microsoft Store"),
    ("Microsoft.WindowsCamera", "Camera"),
    ("Microsoft.WindowsCalculator", "Calculator"),
    ("Microsoft.Windows.Photos", "Photos"),
    ("Microsoft.ScreenSketch", "Snip & Sketch"),
    ("Microsoft.MicrosoftStickyNotes", "Sticky Notes"),
    ("Microsoft.XboxApp", "Xbox")
)


Write-Host "The following apps have been uninstalled:"


# Uninstall from Remove List
foreach ($app in $Remove) {
    # Write-Host 'Removing' $app[0] 'by name' $app[1]
    $app_wildcards = "*" + $app[0] + "*"
    # Write-Host $app_wildcards
    Get-AppxPackage $app_wildcards | Remove-AppxPackage
    Write-Host $app[1]
}

# Uninstall from Optional List, after asking
foreach ($app in $Optional) {
    $confirmation = Read-Host "Would you like to uninstall" $app[1] "? (y/n)"
    if ($confirmation -eq 'y' -or $confirmation -eq 'Y') {
        # Write-Host 'Removing' $app[0] 'by name' $app[1]
        $app_wildcards = "*" + $app[0] + "*"
        # Write-Host $app_wildcards
        Get-AppxPackage $app_wildcards | Remove-AppxPackage
        Write-Host $app[1]
    }
}


# OneDrive
$onedriveConfirmation = Read-Host "Would you like to uninstall OneDrive? (y/n)"
if ($onedriveConfirmation -eq 'y') {
    Get-Process onedrive | Stop-Process -Force
    Start-Process "$env:windir\SysWOW64\OneDriveSetup.exe" "/uninstall"
    Write-Host "OneNote"
}

Read-Host "Press enter to exit"