# Alias
Set-Alias vim nvim
Set-Alias python python3
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias tt tree
Set-Alias gti git
Set-Alias renv Reload-Env
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

Invoke-Expression "$(vfox activate pwsh)"

# Commands
function which ($command)
{
	Get-command -Name $command -ErrorAction SilentlyContinue |
		Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function gdiff ($path)
{
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

Register-ArgumentCompleter -CommandName 'cwd' -ParameterName 'Directory' -ScriptBlock {
	param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

		$directories = Get-ChildItem -Directory

		$directories -like "$wordToComplete*" | ForEach-Object { (Get-Item $_).FullName -replace [regex]::Escape((Get-Location).Path), '.' }
}

Import-Module -Name Terminal-Icons

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -BellStyle none
Set-PSReadLineOption -HistoryNoDuplicates

# Import-Module C:\Users\GiorgioMatacera\Documents\winwal\winwal.psm1

function Test-XmlFile
{
	<#
		.Synopsis
		Validates an xml file against an xml schema file.
		.Example
		PS> dir *.xml | Test-XmlFile schema.xsd
#>
		[CmdletBinding()]
		param (     
				[Parameter(Mandatory=$true)]
				[string] $SchemaFile,

				[Parameter(ValueFromPipeline=$true, Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
				[alias('Fullname')]
				[string] $XmlFile,

				[scriptblock] $ValidationEventHandler = { Write-Error $args[1].Exception }
			  )

			begin
			{
				$schemaReader = New-Object System.Xml.XmlTextReader $SchemaFile
					$schema = [System.Xml.Schema.XmlSchema]::Read($schemaReader, $ValidationEventHandler)
			}

	process
	{
		$ret = $true
			try
			{
				$xml = New-Object System.Xml.XmlDocument
					$xml.Schemas.Add($schema) | Out-Null
					$xml.Load($XmlFile)
					$xml.Validate({
							throw ([PsCustomObject] @{
									SchemaFile = $SchemaFile
									XmlFile = $XmlFile
									Exception = $args[1].Exception
									})
							})
			} catch
		{
			Write-Error $_
				$ret = $false
		}
		$ret
	}

	end
	{
		$schemaReader.Close()
	}
}

function Close-Process-Listening-On-Port
(
 [Parameter(Mandatory=$true)]
 [Int32]
 $Port
 )
{
	Get-NetTCPConnection -LocalPort $Port -State Listen | ForEach-Object { taskkill /PID $_.OwningProcess /F }
}


Register-ArgumentCompleter -CommandName 'Close-Process-Listening-On-Port' -ParameterName 'Port' -ScriptBlock {
	param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

		Get-NetTCPConnection -State Listen | ForEach-Object {$_.LocalPort} | Sort-Object | Get-Unique
}


function Reload-Env
{
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
}

<#
Trasforma tutte le subdirectory (solo primo livello) in .zip:
- Crea: <NomeSubdir>.zip nella directory principale
- Non elimina il contenuto: lo comprime nello zip
- Elimina la subdirectory dopo aver creato lo zip
- Non elimina la directory principale
#>

function Zip-Subdirs(
		[Parameter(Mandatory = $true)]
		[string]$RootPath
		)
{
	Set-StrictMode -Version Latest
		$ErrorActionPreference = "Stop"

		if (-not (Test-Path -LiteralPath $RootPath -PathType Container)) {
			throw "Directory non trovata o non valida: $RootPath"
		}

# Prende solo le sottocartelle immediate (no ricorsivo)
	$subdirs = Get-ChildItem -LiteralPath $RootPath -Directory

		foreach ($dir in $subdirs) {
			$zipPath = Join-Path -Path $RootPath -ChildPath ($dir.Name + ".zip")

				if (Test-Path -LiteralPath $zipPath) {
					Write-Warning "ZIP già esistente, salto: $zipPath"
						continue
				}

# Comprime il contenuto della sottocartella (non la cartella come contenitore)
			$sourcePattern = Join-Path -Path $dir.FullName -ChildPath "*"

				Write-Host "Creo ZIP: $zipPath"
				Compress-Archive -Path $sourcePattern -DestinationPath $zipPath -Force

# Verifica minima che lo zip esista e non sia vuoto (best-effort)
				$zipInfo = Get-Item -LiteralPath $zipPath
				if ($zipInfo.Length -le 0) {
					throw "ZIP creato ma risulta vuoto: $zipPath (non elimino la cartella sorgente)"
				}

			Write-Host "Elimino cartella: $($dir.FullName)"
				Remove-Item -LiteralPath $dir.FullName -Recurse -Force
		}

	Write-Host "Operazione completata. Directory principale lasciata intatta: $RootPath"
}

function Add-ToEnviromentVariables {
	[CmdletBinding()]
	param (
		[Parameter(
		  Mandatory = $true,
		  ValueFromPipeline = $true,
		  ValueFromPipelineByPropertyName = $true
		)]
		[string]$Path,
		[Parameter(Mandatory=$true)]
		[System.EnvironmentVariableTarget]
		$Scope
	)
	$issu = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
	$arrPath = [System.Environment]::GetEnvironmentVariable('PATH', $Scope) -split ';'
	$value = ($arrPath + $Path) -join ';'
	if (($Scope -eq [System.EnvironmentVariableTarget]::Machine) -and (-not ($issu))) {
		gsudo [System.Environment]::SetEnvironmentVariable('PATH', $value, $Scope)
	} else {
		[System.Environment]::SetEnvironmentVariable('PATH', $value, $Scope)
	}
	renv
}
