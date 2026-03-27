# Alias
Set-Alias vim nvim
Set-Alias python python3
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tt tree
Set-Alias gti git
Set-Alias zed "C:\msys64\ucrt64\bin\zed.exe"
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

function gdiff ($path) {
    git diff --ignore-all-space $path
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

function SpeedUp-Video
{
    param(
        [string]$Video,
        [string]$Output = "output.mp4",
        [double]$Factor = 1.25
    )
    
    Write-Host $Video $Output

    ffmpeg.exe -i "$Input" -filter_complex `
        "[0:v]setpts=PTS/$Factor[v];[0:a]atempo=$Factor[a]" `
        -map "[v]" -map "[a]" `
        -c:v libx264 -preset veryfast -crf 18 `
        -c:a aac -b:a 192k `
        "$Output"
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
