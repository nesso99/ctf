-- -----------------------------------------------------
-- FSG v2.0 OEP Script                                --
-- Date: 11.17.2013                                   --
-- OD Version: OllyDbg201(H,I)                        --
-- Achieved With Lua (playtime)                       --
-- Author: quygia128 | CiN1                           --
-- Special thanks to author of "playtime" plugin.     --
-- -----------------------------------------------------

local pos = FindMemory(EIP,"87??????????6194")

if (pos ~= 0) then
	print("File Was Packed By FSG v2.0")
	
	for i = 0, 3 do
		RemoveHardBreakpoint(i)
	end
	
	for i = 0, 3 do
		StepOver()
	end
	
	local Slot = FindFreeHardBreakSlot()

	if (SetHardBreakpoint(Slot, ESP, 1, BP_MANUAL + BP_BREAK + BP_READ + BP_WRITE)) then
		print("Set hardware breakpoint")
	end
	
	-- Run for ESP read
	Continue()

	-- Remove HWBP
	RemoveHardBreakpoint(Slot)
	
	pos = FindMemory(EIP,"FF63??")
	if pos ~= 0 then
		SetInt3Breakpoint(pos, BP_MANUAL + BP_SET + BP_BREAK)
		Continue()
		RemoveInt3Breakpoint(pos, BP_MANUAL + BP_SET + BP_BREAK)
		StepOver()
		SetComment(EIP,"This is OEP :)")
	else
		MsgBox("Script not success","ERROR!")
	end
else
	MsgBox("File Not Pack By FSG v2.0","ERROR!")
end