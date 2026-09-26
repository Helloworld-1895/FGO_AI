Option Explicit

Dim shell, files, root, scriptPath, command, i
Set shell = CreateObject("WScript.Shell")
Set files = CreateObject("Scripting.FileSystemObject")
root = files.GetParentFolderName(WScript.ScriptFullName)
scriptPath = root & "\scripts\bootstrap.ps1"
shell.CurrentDirectory = root
command = "powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File " & Quote(scriptPath)
For i = 0 To WScript.Arguments.Count - 1
  command = command & " " & Quote(WScript.Arguments(i))
Next
On Error Resume Next
shell.Run command, 0, False
If Err.Number <> 0 Then
  If Not files.FolderExists(root + "\logs") Then files.CreateFolder(root + "\logs")
  files.OpenTextFile(root + "\logs\launcher-error.log", 8, True).WriteLine Err.Description
End If

Function Quote(value)
  Quote = Chr(34) & Replace(value, Chr(34), Chr(34) & Chr(34)) & Chr(34)
End Function
