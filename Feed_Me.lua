Feed_Me = LibStub("AceAddon-3.0"):NewAddon("Feed_Me", "AceConsole-3.0")

local defaults = {
  profile = {
    enableAlert = true,
    enableButton = true,
    buttonOnlyWhenAlert = true,
    framePosition = {
      x = 0,
      y = 0
    },
  },
}

local options = {
  name = "Feed_Me",
  handler = Feed_Me,
  type = "group",
  args = {
    enableAlert = {
      name = "1",
      desc = "1",
      type = "toggle",
      get = function() return Feed_Me.db.profile.enableAlert end,
      set = function(_, value)
        Feed_Me.db.profile.enableAlert = value
        -- Feed_Me:UpdateTimerInterval()
      end,
      width = "full",
    },
    enableButton = {
      name = "1",
      desc = "1",
      type = "toggle",
      get = function() return Feed_Me.db.profile.enableButton end,
      set = function(_, value)
        Feed_Me.db.profile.enableButton = value
        -- Feed_Me:UpdateTimerInterval()
      end,
      width = "full",
    },
    buttonOnlyWhenAlert = {
      name = "1",
      desc = "1",
      type = "toggle",
      get = function() return Feed_Me.db.profile.buttonOnlyWhenAlert end,
      set = function(_, value)
        Feed_Me.db.profile.buttonOnlyWhenAlert = value
        -- Feed_Me:UpdateTimerInterval()
      end,
      width = "full",
    },
  },
}


local AceGUI = LibStub("AceGUI-3.0")


function Feed_Me:CreateButton()
  _G.frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
  frame:SetSize(50, 50)
  frame:SetPoint("CENTER")
  frame:SetMovable(true)
  frame:SetUserPlaced(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")
  frame:SetScript("OnDragStart", frame.StartMoving)
  frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save the frame's position
    Feed_Me.db.profile.framePosition.x = self:GetLeft()
    Feed_Me.db.profile.framePosition.y = self:GetTop()
  end)
  frame:SetBackdropColor(1, 0, 0, 0.5)                                            -- Set the frame's background color to semi-transparent red
  frame:SetScript("OnEnter", function() frame:SetBackdropColor(1, 0, 0, 0.5) end) -- Set the frame's background color to its original color when the mouse enters the frame
  frame:SetScript("OnLeave", function() frame:SetBackdropColor(0, 0, 0, 1) end)   -- Set the frame's background color to black when the mouse leaves the frame
  frame:Show()                                                                    -- Make the frame visible
  frame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
      }
)


  _G.btn = CreateFrame("Button", nil, frame, "SecureActionButtonTemplate")
  btn:SetAttribute("type", "macro")
  btn:SetAttribute("macrotext", "/cast Feed Pet \n/use Mutton Chop")
  -- btn:SetAttribute("macrotext", "/cast Feed Pet \n/use " .. BestFood)
  btn:EnableMouse(true)
  btn:SetNormalTexture("Interface\\Icons\\ability_hunter_beasttraining")
  btn:SetSize(32, 32)
  btn:SetPoint("CENTER", frame, "CENTER")
end

function Feed_Me:OnInitialize()
  Feed_Me:CreateButton()
  self.db = LibStub("AceDB-3.0"):New("Feed_MeDB", defaults, true)
  LibStub("AceConfig-3.0"):RegisterOptionsTable("Feed_Me", options)
  self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('Feed_Me', 'Feed_Me')
  self:RegisterChatCommand("rl", function() ReloadUI() end)
  self:RegisterChatCommand("fmo", "OpenConfigMenu")
  self:RegisterChatCommand("feedme", "OpenConfigMenu")
  self:RegisterChatCommand("feedme", "OpenConfigMenu")
  Feed_Me:FeedPet()
  _G.frame:Hide()
  local checkPetHappiness = function() Feed_Me:CheckPetHappiness() end
  C_Timer.NewTicker(1, checkPetHappiness)
end

function Feed_Me:CheckPetHappiness()
  local petHappiness = GetPetHappiness()
  if petHappiness == 1 or petHappiness == 2 then
    Feed_Me:FeedPet()
    local bestFood = GetBestFood(speciesType)
    btn:SetAttribute("macrotext", "/cast Feed Pet \n/use " .. bestFood)
    _G.frame:Show()
  elseif petHappiness == 3 then
    _G.frame:Hide()
  end
end

-- Check pet happiness every second




function Feed_Me:OpenConfigMenu()
  InterfaceOptionsFrame_OpenToCategory("Feed_Me")
end

function Feed_Me:FeedPet()
  petIcon, petName, petLevel, speciesType, petTalents = GetStablePetInfo(0)

  local bestFood = GetBestFood(speciesType)

  -- Now you can use the bestFood variable in your code
  if bestFood ~= nul then
    -- print("The best food for the pet is: " .. bestFood)
  end
end
