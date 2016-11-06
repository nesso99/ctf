Option Explicit

Dim Shell, RegClass

Sub RegisterShell
	Set Shell = WScript.CreateObject("WScript.Shell")
End Sub

Class StartScript

	Function UpdateEx
		Dim n
		Dim fso, f
			Set fso = CreateObject("Scripting.FileSystemObject")
			For n = 0 To 15000000 		'Waiting For OllyDbg UnLoad Plugin & Destroy
				n = n + 1
			Next
			Set f = fso.GetFile("G:\Test_ScyllaHide Plugin\Plugins\OD2ExPlug.DLL")
			f.copy("G:\Test_ScyllaHide Plugin\Plugins\OD2ExPlug.DLL"+".BAK") 			' Backup File
			Set f = fso.GetFile("G:\Test_ScyllaHide Plugin\Plugins\EXP"+"\OD2ExPlug.DL_")
			f.copy("G:\Test_ScyllaHide Plugin\Plugins\OD2ExPlug.DLL")
		MsgBox("OD2ExPlug Have Been Updated To The Latest Version")
		Shell.Exec "G:\Test_ScyllaHide Plugin\ollydbg.exe" 'ReOpen OllyDbg
	End Function

End Class

RegisterShell

Set RegClass = New StartScript
RegClass.UpdateEx

WScript.Quit

'OD2ExPlug Update Script
'Copyright (C) 2012-2014 CiN1 Team
'Author: quygia128

