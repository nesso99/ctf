-- PECompact 3.02.X OEP Script
-- OD Version: OllyDbg201(H,I)
-- Achieved With Lua (playtime)
-- Author: quygia128 | CiN1
-- Date: 11.03.2013

local pos = FindMemory(EIP,"B8????????5064")

if (pos ~= 0) then
	print("File Was Packed By PECompact 3.02.X")
	
	-- Step over mov..., push eax
	StepOver()
	StepOver()

	-- Remove all HWBPs slot(0->3).This's Bad. I'm think it should be
	-- RemoveHardBreakpoint() to REMOVE ALL Hardware BreakPoints
	-- RemoveInt3Breakpoint() to REMOVE ALL INT3 BreakPoints.
	for i = 0, 3 do -- for .. do
		RemoveHardBreakpoint(i) -- Loop 4 times
	end

	-- HWBP on ESP
	local Slot = FindFreeHardBreakSlot()

	if (SetHardBreakpoint(Slot, ESP, 1, BP_MANUAL + BP_BREAK + BP_READ + BP_WRITE)) then -- HWBP Size 1
		print("Set hardware breakpoint")
	end

	-- Run for ESP read
	local n = 3

	while n > 0 do -- while .. do
		Continue() -- Run 3 times
		n = n - 1
	end

	-- Remove HWBP
	RemoveHardBreakpoint(Slot)

	-- Find Jump
	pos = FindMemory(EIP, "FFE0")
	print("Jump Location:", pos)

	if (pos ~= 0) then
	
		-- Breakpoint at JMP EAX
		SetInt3Breakpoint(pos, BP_MANUAL + BP_SET + BP_BREAK)
	
		-- Run
		Continue()
	
		-- Remove at JMP EAX
		RemoveInt3Breakpoint(pos, BP_MANUAL or BP_SET or BP_BREAK) -- "or"
	
		-- Get into JMP
		StepIn()
	
		-- Determine if the current instruction is a call
		if (BYTE_PTR[EIP] == 0x00) then
			MsgBox("Script probably failed", "ERROR!")
		else
			RedrawCPUDisasm()
			print("OEP: %X", EIP)  -- Converter Hex ???
			MsgBox("You should be now at the OEP, dump the process", "DONE")
		end
		
	end
	
else 
	MsgBox("File Not Pack By PECompact 3.02.X","ERROR!")
end