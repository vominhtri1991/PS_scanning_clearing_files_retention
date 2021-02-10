$PATHRM=$args[0]
$RETIME=$args[1]
$EXTFILE=$args[2]
$current=Get-Date -Format "ddMMyyyy-HHmm"
$num_argument=$($args.Count)
$logfile="C:/tmp/clearfiles-"+$current+".log"
function exit_arguments($numcount)
{
	if ($numcount -ne 3)
	{
		Write-Host "----------------------------------------------------------"
		Write-Host "Number of argument not valid for running script.Exit now!!!"
		Write-Host "----------------------------------------------------------"
		exit 30

	}
}

function exit_pathscan($pathscan)
{
$check=Test-Path $pathscan -PathType Container
	if(!$check)
	{
			Write-Host "----------------------------------------------------------"
			Write-Host "Path directory for scanning file not existed for running script.Exit now!!!"
			Write-Host "----------------------------------------------------------"
			exit 30
	}
}

exit_arguments($num_argument)sssssssssssss
exit_pathscan($PATHRM)
Write-Host "Do you want to remove file with below condition?"
Write-Host "\nExtension of files: $EXTFILE"
Write-Host "\nPath scanning files: $PATHRM"
Write-Host "\nRention to keep files: $RETIME days"
$choice = Read-Host -Prompt "Do you want to coninue scan and remove file? (Y/N): " 
Write-Host $choice
	if ($choice -eq "Y")
	{
		Add-content -Path $logfile -value "List files removed:"
		$filelist=Get-ChildItem -Path $PATHRM -Filter *.$EXTFILE -File  | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-$RETIME)}
		foreach($afile in $filelist)
		{
			Write-Host $afile.FullName
			Add-content -Path $logfile -value $afile.FullName
			Remove-Item -Path $afile.FullName
		}
		Write-Host "List of file removing by script will be logging at file: $logfile"
	}
	else
	{
		Write-Host "Exiting script not scanning and removing any files!!!"
        Write-Host "----------------------------------------------------------"
        exit 36
	}