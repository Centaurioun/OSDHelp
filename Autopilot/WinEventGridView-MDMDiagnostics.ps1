#Requires -RunAsAdministrator
#================================================
#   Initialize
#================================================
$Title = 'WinEventMonitor-MDMDiagnostics'
$host.ui.RawUI.WindowTitle = $Title
#================================================
#   Main Variables
#================================================
$FormatEnumerationLimit = -1
# This will go back 5 days in the logs.  Adjust as needed
$StartTime = (Get-Date).AddDays(- 5)
$ExcludeEventId = @(200,202,260,263,272)
#================================================
#   LogName
#   These are the WinEvent logs to monitor
#================================================
$LogName = @(
    'Microsoft-Windows-AAD/Operational'
    'Microsoft-Windows-AssignedAccess/Admin'
    'Microsoft-Windows-AssignedAccess/Operational'
    'Microsoft-Windows-AssignedAccessBroker/Admin'
    'Microsoft-Windows-AssignedAccessBroker/Operational'
    'Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin'
    'Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Operational'
    'Microsoft-Windows-ModernDeployment-Diagnostics-Provider/Autopilot'
    'Microsoft-Windows-ModernDeployment-Diagnostics-Provider/ManagementService'
    'Microsoft-Windows-Provisioning-Diagnostics-Provider/Admin'
    'Microsoft-Windows-Shell-Core/Operational'
    'Microsoft-Windows-Time-Service/Operational'
    'Microsoft-Windows-User Device Registration/Admin'
)
#================================================
#   FilterHashtable
#================================================
$FilterHashtable = @{
    StartTime = $StartTime
    LogName = $LogName
}
#================================================
#   Get-WinEvent Results
#================================================
$Results = Get-WinEvent -FilterHashtable $FilterHashtable -ErrorAction Ignore
$Results = $Results | Sort-Object TimeCreated | Where-Object {$_.Id -notin $ExcludeEventId}
$Results | Out-GridView


#$Events | Where-Object {$_.id -notin (182)} | Sort-Object TimeCreated | Select-Object TimeCreated,LevelDisplayName,LogName,Id,Message,ProviderName | Out-GridView