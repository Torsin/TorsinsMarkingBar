TMB = LibStub("AceAddon-3.0"):NewAddon("Torsins Marking Bar", "AceEvent-3.0", "AceConsole-3.0")

TMB.AddOn_Name = "Torsins Marking Bar"

local defaults = {
	char = {
		Settings = {
			Frame = {
				height = 30,
				top = 800,
				left = 675,
				width = 255,
			},
			Icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8",
			Locked = false,
			Minimap = {
				hide = true,
			},
			Orientation = false,  -- false = Horiztontal, true = Vertical
		},
	},
}


-- Command line options
local options = {
    name = "ICBG Guild Lottery",
    handler = TMB,
    type = "group",
    args = {
        Hide = {
            type = "execute",
            name = "Hide",
            desc = "Hide the addon Interface.",
			func = "Hide",
        },
        show = {
            type = "execute",
            name = "Show",
            desc = "Show the addon Interface.",
			func = "OpenLotto",
        },
    },
}


--Register the addon with LibDataBroker for the minimap button
TMB_LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Torsins Marking Bar", {
	type = "launcher",
	text = "Torsins Marking Bar",
	icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8",
	OnClick = function(self, button, down)
		if button == "LeftButton" then
			TMB:Open()
		end
	end,
	OnTooltipShow = function(tt)
		tt:AddLine("Click to Show/Hide the Marking Bar");
		tt:AddLine(TMB.AddOn_Name.."  [Version: "..GetAddOnMetadata("TorsinsMarkingBar", "Version").."]");
	end
})
_Icon = LibStub:GetLibrary("LibDBIcon-1.0")

function TMB:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("TorsinsMarkingBarDB", defaults)

	_Icon:Register("Torsins Marking Bar", TMB_LDB, self.db.char.Settings.Minimap)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("Torsins Marking Bar", options, {"tmb"})
end

function TMB:OnEnable()
	self:RefreshConfig()

	TMB:Show()
end

function TMB:RefreshConfig()
	self:UpdateMinimap()
end

-- Hide or Show the minimap icon
function TMB:UpdateMinimap()
	TMB_LDB.icon = self.db.char.Settings.Icon

	if self.db.char.Settings.Minimap.hide or not TMB:IsEnabled() then
		_Icon:Hide(TMB.AddOn_Name)
	else
		_Icon:Show(TMB.AddOn_Name)
	end
end

function TMB:UIresettoDefault()
	--TMB:Hide()
	self.db:ResetDB("TorsinsMarkingBarDB", "char")
	--TMB:OpenSettings()
end
