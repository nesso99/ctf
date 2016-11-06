-- -----------------------------------------------------
-- ZProtect v1.4.9.0 OEP Script (*.exe,*.dll)         --
-- Date: 11.17.2013                                   --
-- OD Version: OllyDbg201(H,I)                        --
-- Achieved With Lua (playtime)                       --
-- Author: quygia128 | CiN1                           --
-- Special thanks to author of "playtime" plugin.     --
-- -----------------------------------------------------

local pos = FindMemory(EIP,"E801????????????24")

if (pos ~= 0) then
	print("File Was Packed By zProtect v1.4.9.0")
	
	-- Remove all HWBPs
	for i = 0, 3 do
		RemoveHardBreakpoint(i) -- Loop 4 times
	end
	
	-- Step in
	for i = 0, 5 do
		StepIn()
	end
	
	-- HWBP on ESP
	local Slot = FindFreeHardBreakSlot()

	if (SetHardBreakpoint(Slot, ESP, 1, BP_MANUAL + BP_BREAK + BP_READ + BP_WRITE)) then
		print("Set hardware breakpoint")
	end

	-- Run for ESP read
	Continue()

	-- Remove HWBP
	RemoveHardBreakpoint(Slot)

	-- Step in
	if (BYTE_PTR[EIP] == 0xE8) then
		-- For *.dll file
		for i = 0, 5 do
			StepIn() 
		end	
	else 
		-- For *.exe file
		for i = 0, 1 do
			StepIn()
		end		
	end
	
	if (BYTE_PTR[EIP] == 0x00) then
			MsgBox("Script probably failed", "ERROR!")
	else
		RedrawCPUDisasm()
		print("OEP: ", EIP)
		SetComment(EIP,"This is OEP")
	end
	
else 
	MsgBox("File Not Pack By ZProtect v1.4.9.0","ERROR!")
end