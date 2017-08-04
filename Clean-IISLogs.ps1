$IISLogs = (Get-WebConfigurationProperty "/system.applicationHost/sites/siteDefaults" -name logfile.directory).Value
$IISLogs = $IISLogs -replace "%SystemDrive%",$env:systemdrive

Get-ChildItem -Path $IISLogs -Include *.log -Recurse | where {$_.LastWriteTime -lt (Get-Date).addDays(-60)} | foreach {Remove-Item $_.FullName}

Get-ChildItem -Path $env:systemroot\System32\LogFiles\HTTPERR -Include *.log -Recurse | where {$_.LastWriteTime -lt (Get-Date).addDays(-60)} | foreach {Remove-Item $_.FullName}
