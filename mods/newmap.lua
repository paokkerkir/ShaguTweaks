local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T
  -- compatibility for turtle-wow's worldmap window
local module = ShaguTweaks:register({
  title = "WorldMap TurtleCompat",
  description = "Compatibility fix for Turtle-WoW's worldmap window",
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = T["World & MiniMap"],
  enabled = true,
})

module.enable = function(self)
  local HookWorldMapFrame_Maximize = WorldMapFrame_Maximize
  WorldMapFrame_Maximize = function()
    -- run original function
    HookWorldMapFrame_Maximize()

    -- re-apply worldmap window if ShaguTweaks worldmap window module is enabled
    if ShaguTweaks_config and ShaguTweaks_config[T["WorldMap Window"]] == 1 then
      WorldMapFrame:SetMovable(true)
      WorldMapFrame:EnableMouse(true)

      WorldMapFrame:SetScale(.85)
      WorldMapFrame:ClearAllPoints()
      WorldMapFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 30)
      WorldMapFrame:SetWidth(WorldMapButton:GetWidth() + 15)
      WorldMapFrame:SetHeight(WorldMapButton:GetHeight() + 55)

      -- overwrite wrong title position set by turtlewow
      WorldMapFrameTitle:SetPoint("TOP", WorldMapFrame, 0, 17)

      BlackoutWorld:Hide()
    end
  end
      -- trigger once to avoid graphical glitches
  WorldMapFrame_Maximize()
end

