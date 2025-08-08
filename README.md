# Microsoft Defender LiveResponse RAW script parser
Microsoft Defender LiveResponse script which will convert your Windows PowerShell script to LR Defender invoker

## Background

This script helps you automate converting your Windows PowerShell script to be accepted by Microsoft LiveResponse console. This, what you convert by using this script allows you to run it via LR-Defender-invoker available on this GitHub.

## Get started

This script you have to run on your workstation. No need to upload it anywhere

## How it works

It converts your original Windows PowerShell script to version with characters set and sytanx allowing to run via LR-Defender-invoker available on this GitHub.

## Usage

Run script on your workstation to load function
```
powershell.exe -noexit -ExecutionPolicy Bypass -File .\msdefparser.ps1
```
Execute function against file
```
Convert-ToDefenderSafeString -InputFile '.\test2.ps1'
```
Windows PowerShell script from file before convertion
```
$targetProcesses = @("powershell", "explorer", "chrome")
$matchedProcesses = Get-Process | Where-Object { $targetProcesses -contains $_.ProcessName }
foreach ($proc in $matchedProcesses) {
    $name = $proc.ProcessName
    $id = $proc.Id
    $cpu = "{0:N2}" -f $proc.CPU
    $memory = "{0:N2}" -f ($proc.WorkingSet / 1MB)
    $message = "Process '$name' (ID: $id) is using $memory MB of memory and $cpu seconds of CPU time."
    Write-Host $message
}
```
Output: 
```
#D#targetProcesses = @#LP##Q#powershell#Q#, #Q#explorer#Q#, #Q#chrome#Q##RP##S# #D#matchedProcesses = Get-Process #P# Where-Object { #D#targetProcesses -contains #D#_.ProcessName }#S# foreach #LP##D#proc in #D#matchedProcesses#RP# {     #D#name = #D#proc.ProcessName#S#     #D#id = #D#proc.Id#S#     #D#cpu = #Q#{0:N2}#Q# -f #D#proc.CPU#S#     #D#memory = #Q#{0:N2}#Q# -f #LP##D#proc.WorkingSet / 1MB#RP##S# #D#message = #Q#Process ''#D#name'' #LP#ID: #D#id#RP# is using #D#memory MB of memory and #D#cpu seconds of CPU time.#Q##S#     Write-Host #D#message }
```
Execute function against typed command
```
 Convert-ToDefenderSafeString -CommandString '$PSVersionTable.PSVersion'
```
Output:
```
#D#PSVersionTable.PSVersion
```
