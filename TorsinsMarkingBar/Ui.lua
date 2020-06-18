local TMB = LibStub("AceAddon-3.0"):GetAddon("Torsins Marking Bar")

local function closeOnClick(this)
	PlaySound(PlaySoundKitID and "gsTitleOptionExit" or 799) -- SOUNDKIT.GS_TITLE_OPTION_EXIT
	local frame = this:GetParent()
	frame:Hide()
end

local function frameOnMouseDown(this)
	if not TMB:CheckLock() then
		this:StartMoving()
	end
end

function TMB:CheckLock()
	if self.db.char.Settings.Locked then
		return true
	else
		return false
	end
end

local function frameOnMouseUp(this)
	this:StopMovingOrSizing()

	TMB:SavePosition(this:GetWidth(), this:GetHeight(), this:GetTop(), this:GetLeft())
end

function TMB:SavePosition(width, height, top, left)
	self.db.char.Settings.Frame.width	= width
	self.db.char.Settings.Frame.height	= height
	self.db.char.Settings.Frame.top		= top
	self.db.char.Settings.Frame.left	= left
end

local defaultBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4,}
}
local borderlessBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	tile = true,
	tileSize = 16
}

function TMB:MainFrame()
	local tempHeight	= self.db.char.Settings.Frame.height
	local tempWidth		= self.db.char.Settings.Frame.width
	if self.db.char.Settings.Orientation then --Vertical orientation (width should be less than the height)
		if self.db.char.Settings.Frame.width > self.db.char.Settings.Frame.height then
			tempHeight	= self.db.char.Settings.Frame.width
			tempWidth	= self.db.char.Settings.Frame.height
		end
	else -- Horizontal orientation (width should be longer than height)
		if self.db.char.Settings.Frame.width < self.db.char.Settings.Frame.height then
			tempHeight	= self.db.char.Settings.Frame.width
			tempWidth	= self.db.char.Settings.Frame.height
		end
	end
	-- We take the temp values, that should be appropriately set for vertical/horiztonal
	self.db.char.Settings.Frame.height	= tempHeight
	self.db.char.Settings.Frame.width	= tempWidth


	TMB_Frame = CreateFrame("Frame", "TMB_Frame",UIParent)
	TMB_Frame:SetWidth(self.db.char.Settings.Frame.width)
	TMB_Frame:SetHeight(self.db.char.Settings.Frame.height)
	TMB_Frame:SetPoint("TOP",UIParent,"BOTTOM",0,self.db.char.Settings.Frame.top)
	TMB_Frame:SetPoint("LEFT",UIParent,"LEFT",self.db.char.Settings.Frame.left,0)
	TMB_Frame:EnableMouse()

	TMB_Frame:SetMovable(not self.db.char.Settings.Locked)

	TMB_Frame:SetResizable(false)
	TMB_Frame:SetFrameStrata("HIGH")
	TMB_Frame:SetScript("OnMouseDown", frameOnMouseDown)
	TMB_Frame:SetScript("OnMouseUp", frameOnMouseUp)

	TMB_Frame:SetMinResize(240,240)
	TMB_Frame:SetToplevel(true)

	TMB_Frame:SetBackdrop(borderlessBackdrop)
	TMB_Frame:SetBackdropColor(0.1,0.1,0.1,0.7)

	local close = CreateFrame("Button", nil, TMB_Frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", 2, 1)
	close:SetScript("OnClick", closeOnClick)
	self.closebutton = close
	close.obj = self

	local skullMark = CreateFrame("Button", "skullMark", TMB_Frame, "SecureActionButtonTemplate")
	skullMark:SetSize(15,15)
	skullMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_8")
	skullMark:SetPoint("TOPLEFT", TMB_Frame, "TOPLEFT",5,-7)
	skullMark:SetAttribute("type", "macro")
	skullMark:SetAttribute("macrotext1", "/worldmarker 8")
	skullMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("White marker",0.88,0.65,0); GameTooltip:Show() end)
	skullMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local xMark = CreateFrame("Button", "xMark", TMB_Frame, "SecureActionButtonTemplate")
	xMark:SetSize(15,15)
	xMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_7")
	xMark:SetPoint("LEFT", skullMark, "RIGHT",5,0)
	xMark:SetAttribute("type", "macro")
	xMark:SetAttribute("macrotext1", "/worldmarker 4")
	xMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Red marker",0.88,0.65,0); GameTooltip:Show() end)
	xMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local squareMark = CreateFrame("Button", "squareMark", TMB_Frame, "SecureActionButtonTemplate")
	squareMark:SetSize(15,15)
	squareMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_6")
	squareMark:SetPoint("LEFT", xMark, "RIGHT",5,0)
	squareMark:SetAttribute("type", "macro")
	squareMark:SetAttribute("macrotext1", "/worldmarker 1")
	squareMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Blue marker",0.88,0.65,0); GameTooltip:Show() end)
	squareMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local moonMark = CreateFrame("Button", "moonMark", TMB_Frame, "SecureActionButtonTemplate")
	moonMark:SetSize(15,15)
	moonMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_5")
	moonMark:SetPoint("LEFT", squareMark, "RIGHT",5,0)
	moonMark:SetAttribute("type", "macro")
	moonMark:SetAttribute("macrotext1", "/worldmarker 7")
	moonMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Silver marker",0.88,0.65,0); GameTooltip:Show() end)
	moonMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local triMark = CreateFrame("Button", "triMark", TMB_Frame, "SecureActionButtonTemplate")
	triMark:SetSize(15,15)
	triMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_4")
	triMark:SetPoint("LEFT", moonMark, "RIGHT",5,0)
	triMark:SetAttribute("type", "macro")
	triMark:SetAttribute("macrotext1", "/worldmarker 2")
	triMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Green marker",0.88,0.65,0); GameTooltip:Show() end)
	triMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local diaMark = CreateFrame("Button", "diaMark", TMB_Frame, "SecureActionButtonTemplate")
	diaMark:SetSize(15,15)
	diaMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_3")
	diaMark:SetPoint("LEFT", triMark, "RIGHT",5,0)
	diaMark:SetAttribute("type", "macro")
	diaMark:SetAttribute("macrotext1", "/worldmarker 3")
	diaMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Purple marker",0.88,0.65,0); GameTooltip:Show() end)
	diaMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local circleMark = CreateFrame("Button", "circleMark", TMB_Frame, "SecureActionButtonTemplate")
	circleMark:SetSize(15,15)
	circleMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_2")
	circleMark:SetPoint("LEFT", diaMark, "RIGHT",5,0)
	circleMark:SetAttribute("type", "macro")
	circleMark:SetAttribute("macrotext1", "/worldmarker 6")
	circleMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Orange marker",0.88,0.65,0); GameTooltip:Show() end)
	circleMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local starMark = CreateFrame("Button", "starMark", TMB_Frame, "SecureActionButtonTemplate")
	starMark:SetSize(15,15)
	starMark:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_1")
	starMark:SetPoint("LEFT", circleMark, "RIGHT",5,0)
	starMark:SetAttribute("type", "macro")
	starMark:SetAttribute("macrotext1", "/worldmarker 5")
	starMark:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Yellow marker",0.88,0.65,0); GameTooltip:Show() end)
	starMark:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	local clrMarks = CreateFrame("Button", "clrMarks", TMB_Frame, "SecureActionButtonTemplate")
	clrMarks:SetSize(15,15)
	clrMarks:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
	clrMarks:SetPoint("LEFT", starMark, "RIGHT",5,0)
	clrMarks:SetScript("OnClick", function(self) ClearRaidMarker() end)
	clrMarks:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Clear all world markers.",0.88,0.65,0); GameTooltip:Show() end)
	clrMarks:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
--[[
	local roleCheck = CreateFrame("Button", "roleCheck", TMB_Frame)
	roleCheck:SetSize(15,15)
	roleCheck:SetPoint("LEFT", clrMarks , "RIGHT")
	roleCheck:SetNormalTexture("Interface\\RaidFrame\\ReadyCheck-Waiting")
	roleCheck:GetNormalTexture():SetTexCoord(0,1,0,1)
	roleCheck:EnableMouse(true)
	roleCheck:SetScript("OnClick", function(self) InitiateRolePoll() end)
	roleCheck:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Role Poll",0.88,0.65,0); GameTooltip:Show() end)
	roleCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
--]]
	local readyCheck = CreateFrame("Button", "readyCheck", TMB_Frame)
	readyCheck:SetSize(15,15)
	readyCheck:SetPoint("LEFT", clrMarks , "RIGHT")
	readyCheck:SetNormalTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
	readyCheck:GetNormalTexture():SetTexCoord(0,1,0,1)
	readyCheck:SetScript("OnClick", function(self) DoReadyCheck() end)
	readyCheck:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Ready Check",0.88,0.65,0); GameTooltip:Show() end)
	readyCheck:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

	lockIcon = CreateFrame("Button", "lock", TMB_Frame)
	lockIcon:SetSize(15,15)
	lockIcon:SetPoint("LEFT", readyCheck , "RIGHT")
	lockIcon:SetNormalTexture("Interface\\GLUES\\CharacterSelect\\Glues-Addon-Icons")
	if self.db.char.Settings.Locked then
		lockIcon:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
		lockIcon:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Locked",0.88,0.65,0); GameTooltip:Show() end)
	else
		lockIcon:GetNormalTexture():SetTexCoord(0.25, 0.50, 0, 1)
		lockIcon:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_BOTTOM"); GameTooltip:ClearLines(); GameTooltip:AddLine("Unlocked",0.88,0.65,0); GameTooltip:Show() end)
	end
	lockIcon:SetScript("OnClick", function(self) TMB:lockTMB() end)
	lockIcon:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
end


function TMB:lockTMB()
	self.db.char.Settings.Locked = not self.db.char.Settings.Locked

	TMB:Hide()
	TMB:Show()
end

-- toggle visibility of the UI
function TMB:Toggle(tab)
	if not self:IsEnabled() then return end

	if not TMB_Frame then
		self:Show()
	elseif TMB_Frame:IsShown() then
		self:Hide()
	else
		self:Show(tab)
	end
end

-- hide the UI if it is currently showing
function TMB:Hide()
	if ((not self:IsEnabled()) or (not TMB_Frame)) then return end

	TMB_Frame:Hide()
end

-- show the UI if it is not currently showing
function TMB:Show()
	if not self:IsEnabled() then
		return
	elseif TMB_Frame then
		if TMB_Frame:IsShown() then
			return
		end
	end

	TMB:MainFrame()
end

function TMB:Open()
	TMB:Toggle()
end
