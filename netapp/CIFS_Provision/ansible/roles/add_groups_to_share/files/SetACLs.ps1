#Usage SetACLs.ps1 -FC fullcontrolexample -RO readonlyexample -RW modifyexample -server exampleserver -folderpath example

#function Generate-ACLs
#{
param
(
$FC,
$RO,
$RW,
$RE,
$Server,
$FolderPath
)
#Get SIDs of new groups
$FCSID = Get-ADGroup $FC | Select SID
$ROSID = Get-ADGroup $RO | Select SID
$RWSID = Get-ADGroup $RW | Select SID
$RESID = Get-ADGroup $RE | Select SID


$SharePath = "\\" + $Server + "\" + $FolderPath
#$SharePath = $SharePath.Replace('\\', '\')
"SharePath is " + $SharePath
$test = Test-Path $SharePath
"The Path Exists is: " + $test



#Set Permissions
$inherit = [system.security.accesscontrol.InheritanceFlags]"ObjectInherit",[system.security.accesscontrol.InheritanceFlags]"ContainerInherit"
$propagation = [system.security.accesscontrol.PropagationFlags]"None"

#Get the existing ACL
$NewShareACL = Get-Acl $SharePath
#Create new ACL rules for each AD group
$FCAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($FCSID.SID,"FullControl",$inherit, $propagation, "Allow")
$ROAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($ROSID.SID,"Read",$inherit, $propagation,"Allow")
$RWAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($RWSID.SID,"Modify",$inherit, $propagation,"Allow")
$REAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($RESID.SID,"ReadAndExecute",$inherit, $propagation,"Allow")
$Everyone = New-Object System.Security.Principal.NTaccount("Everyone")
#Add ACL Rules to existing ACL
$NewShareACL.AddAccessRule($FCAccessRule)
$NewShareACL.AddAccessRule($ROAccessRule)
$NewShareACL.AddAccessRule($RWAccessRule)
$NewShareACL.AddAccessRule($REAccessRule)
$NewShareACL.PurgeAccessRules($Everyone)
#Enable Inheritance
$NewShareACL.SetAccessRuleProtection($false, $true)
#Write the new ACL to the folder
$NewShareACL | Set-Acl $SharePath

#}