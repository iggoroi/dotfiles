# Alias
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tt tree

# pormpt
function prompt {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        $issu = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
        $HostName = $([System.Net.Dns]::GetHostName())
        $currentDirectory = "$(Get-Location)".Replace("$home", "~")
        $esc = [char]27
        $colorReset = "${esc}[0m"
        if ($issu) {
            $UserColor = "${esc}[38;2;100;100;255m"
                $PathColor = "${esc}[38;2;255;100;0m"
                $ShellColor = "${esc}[38;2;152;54;250m"
                return "$($UserColor)root@$HostName$colorReset`n$PathColor$currentDirectory$colorReset`n$ShellColor# $colorReset"
        } else {
            $UserColor = "${esc}[38;2;254;221;6m"
                $PathColor = "${esc}[38;2;194;202;255m"
                $ShellColor = "${esc}[38;2;170;170;50m"
                return "$($UserColor)$env:USERNAME@$HostName$colorReset`n$PathColor$currentDirectory$colorReset`n$ShellColor`$ $colorReset"
        }
}

# Commands
function which ($command) {
    Get-command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Import-Module -Name Terminal-Icons

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -BellStyle none
Set-PSReadLineOption -HistoryNoDuplicates
