#Pre Steps

#Edit your mercurial.ini for the following removing the hashes
#[extensions]
#hggit = 
#hgext.bookmarks =

#[git]
#intree = True

#Check all ok running 'hg help hggit'


#Run with -localpath and -remotepath
#Exmaple:
#script.ps1 -remotepath \\share\folder -localpath C:\testfolder 

#Take input for path of remote folders and local folder
param (
    [Parameter(Mandatory=$true)][string]$remotepath,
    [Parameter(Mandatory=$true)][string]$localpath
 )

#List all subfolders
$folderRecurseList=Get-ChildItem -Recurse -Directory -Name $remotepath
$folderList=Get-ChildItem -Directory -Name $remotepath

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
foreach ($element in $repos) {
    $leaf = $element|split-path -leaf
    $remlocpath = "$($element) $($localpath)\$($leaf)"
    write-host $remlocpath
    $continue = Read-Host -Prompt 'Clone local? [y or yes]'
    if ( ($continue -eq "y") -or ($continue -eq "yes")) {
        write-host "Cloning"
        #& hg clone $remlocpath
        #hg bookmark -r default master
        #hg gexport --debug
        #git config --bool core.bare false
        #git reset HEAD -- .
        & '$localpath' ./mkdir test

        #PUSH TO BB
    }
    else {
        write-host "Thats a no then"
    }
}