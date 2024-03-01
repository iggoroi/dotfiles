# Alias
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tt tree
Set-Alias gti git

# pormpt
function prompt
{
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $issu = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $HostName = $([System.Net.Dns]::GetHostName())
    $currentDirectory = "$(Get-Location)".Replace("$home", "~")
    if ($issu)
    {
        $UserColor = [System.ConsoleColor]::Blue
        $PathColor = [System.ConsoleColor]::Magenta
        $ShellColor = [System.ConsoleColor]::Cyan
        Write-Host $env:USERNAME@$HostName -ForegroundColor $UserColor
        Write-Host $currentDirectory -ForegroundColor $PathColor
        Write-Host "$" -ForegroundColor $ShellColor -NoNewline
        return " "
    } else
    {
        $UserColor = [System.ConsoleColor]::Magenta
        $PathColor = [System.ConsoleColor]::Red
        $ShellColor = [System.ConsoleColor]::Yellow
        Write-Host $env:USERNAME@$HostName -ForegroundColor $UserColor
        Write-Host $currentDirectory -ForegroundColor $PathColor
        Write-Host "$" -ForegroundColor $ShellColor -NoNewline
        return " "
    }
}

# Commands
function which ($command)
{
    Get-command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function cwd (
    [Parameter(Mandatory=$true)]
    [System.IO.DirectoryInfo]
    $Directory
)
{
    Set-Location $Directory;
    wezterm set-working-directory .
}

function touch ([Parameter(Mandatory=$true)][string]$item)
{
    if ($item -match "^[^~)('!*<>:;,?`"*|/\\]+$" )
    {
        New-Item -Path $item -ItemType File
    } else
    {
        Write-Error "invalid name"
    }
}

Register-ArgumentCompleter -CommandName 'cwd' -ParameterName 'Directory' -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $directories = Get-ChildItem -Directory

    $directories -like "$wordToComplete*" | ForEach-Object { (Get-Item $_).FullName -replace [regex]::Escape((Get-Location).Path), '.' }}

Import-Module -Name Terminal-Icons

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -BellStyle none
Set-PSReadLineOption -HistoryNoDuplicates
