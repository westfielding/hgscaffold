#Assume that
#Run with -path
#script.ps1 -path 


#Take input for path of M folders
param (
    [Parameter(Mandatory=$true)][string]$path
 )

#List all subfolders
$folderRecurseList=Get-ChildItem -Recurse -Directory -Name $path
$folderList=Get-ChildItem -Directory -Name $path

#write-output $folderList
#write-output $folderRecurseList

foreach ($element in $folderRecurseList) {
    if ($element.EndsWith(".hg")) {
        write-output "Found a repo"
        #Time to trim the hg extension
        $folder = $element.TrimEnd("\.hg")
        #Build full path for clone command
        $repos = "$($repos)$($path)\$($folder)"
    }
    else {
        Write-Host "No Repo"
    }
}


#$c = Compare-Object -ReferenceObject $folderList -DifferenceObject $folderRecurseList -PassThru
#write-output $c


write-host $repos


#Run the clone
#& copy 