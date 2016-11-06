-- -----------------------------------------------------
-- WinUpack OEP Script (*.exe)                        --
-- Date: 12.15.2013                                   --
-- OD Version: OllyDbg201(H,I)                        --
-- Achieved With Lua (playtime)                       --
-- Author: quygia128 | CiN1                           --
-- Special thanks to author of "playtime" plugin.     --
-- -----------------------------------------------------

local pos = FindMemory(EIP,"E9????????42")

if (pos ~= 0) then
	print("File Was Packed By WinUpack")

	-- Remove all HWBPs
	for i = 0, 3 do
		RemoveHardBreakpoint(i) -- Loop 4 times
	end

	-- Step in
	for i = 0, 0 do
		StepIn()
	end

	pos = FindMemory(EIP,"0F84????????")
	if pos ~= 0 then
		SetInt3Breakpoint(pos - 2, BP_MANUAL + BP_SET + BP_BREAK)
		Continue()
		repeat
			StepIn()
			Continue()
			if (EAX == 0x00) then
				RemoveInt3Breakpoint(pos - 2, BP_MANUAL + BP_SET + BP_BREAK)
				StepOver()
				StepOver()
				break -- Can remove this command, will break when EAX == 0x00
			end
		until (EAX == 0x00)
	end

	if (BYTE_PTR[EIP] == 0x00) then
		MsgBox("Script probably failed", "ERROR!")
	else
		SetComment(EIP,"<<-- OEP - Script by quygia128")
	end

else 
	MsgBox("File Not Pack By WinUpack","ERROR!")
end