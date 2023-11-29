Feed_Me = LibStub("AceAddon-3.0"):NewAddon("Feed_Me", "AceConsole-3.0")

local defaults = {
  profile = {
    enableAlert = true,
    enableButton = true,
    buttonOnlyWhenAlert = true,
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

local petTypes = {
  "Bats",
  "Bears",
  "Boars",
  "Carrion Birds",
  "Cats",
  "Crabs",
  "Crocolisks",
  "Gorillas",
  "Hyenas",
  "Owls",
  "Raptors",
  "Scorpids",
  "Spiders",
  "Tallstriders",
  "Turtles",
  "Wind Serpents",
  "Wolves",
}
local petDiets = {
  ["Bear"] = { "Bread", "Cheese", "Fish", "Fruit", "Fungus", "Meat" },
  ["Boar"] = { "Bread", "Cheese", "Fish", "Fruit", "Fungus", "Meat" },
  ["Crab"] = { "Bread", "Fish" },
  ["Crocolisk"] = { "Fish", "Meat" },
  ["Gorilla"] = { "Fruit", "Fungus" },
  ["Scorpid"] = { "Meat" },
  ["Tallstrider"] = { "Cheese", "Fruit", "Fungus" },
  ["Turtle"] = { "Fruit", "Fungus" },
  ["Bat"] = { "Fruit", "Fungus" },
  ["Cat"] = { "Fish", "Meat" },
  ["Owl"] = { "Meat" },
  ["Raptor"] = { "Meat" },
  ["Spider"] = { "Meat" },
  ["Wind Serpent"] = { "Bread", "Cheese", "Fish" },
  ["Carrion Bird"] = { "Fish", "Meat" },
  ["Hyena"] = { "Fruit", "Meat" },
  ["Wolf"] = { "Meat" },
}
local foodTypes = {
  Bread = { "Tough Hunk of Bread", "Freshly Baked Bread", "Moist Cornbread", "Mulgore Spice Bread", "Soft Banana Bread", "Homemade Cherry Pie" },
  Cheese = { "Darnassian Bleu", "Dalaran Sharp", "Dwarven Mild", "Fine Aged Cheddar", "Alterac Swiss" },
  Fish = { "Slitherskin Mackerel", "Longjaw Mud Snapper", "Bristle Whisker Catfish", "Rockscale Cod", "Spinefin Halibut" },
  Fruit = { "Shiny Red Apple", "Tel'Abim Banana", "Snapvine Watermelon", "Goldenbark Apple", "Deep Fried Plantains" },
  Fungus = { "Forest Mushroom Cap", "Red-speckled Mushroom", "Spongy Morel", "Raw Black Truffle", "Dried King Bolete" },
  Meat = { "Tough Jerky", "Haunch of Meat", "Mutton Chop", "Cured Ham Steak", "Roasted Quail", "Wild Hog Shank" },
}

local AceGUI = LibStub("AceGUI-3.0")

local button = CreateFrame("Button", nil, UIParent, "BackdropTemplate")
button:SetSize(32, 32)
button:SetPoint("CENTER", 0, 0)
button:SetFrameStrata("DIALOG")
button:SetBackdrop({
  bgFile = "Interface\\Buttons\\UI-Panel-Button-Up",
  edgeFile = "Interface\\Buttons\\UI-Panel-Button-Border",
  tile = true,
  tileSize = 32,
  edgeSize = 16,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
button:SetBackdropColor(0, 0, 0, 0.5)
button:SetAttribute("type", "macro")
button:SetAttribute("macrotext", "/cast Feed Pet; /use Mutton Chop")



function Feed_Me:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("Feed_MeDB", defaults, true)
  print("WIP")
  print("WIP")
  print("WIP")
  print("WIP")
  print("WIP")
  print("WIP")
  print("WIP")
  LibStub("AceConfig-3.0"):RegisterOptionsTable("Feed_Me", options)
  self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('Feed_Me', 'Feed_Me')
  self.IS_RUNNING = false
  self:RegisterChatCommand("rl", function() ReloadUI() end) -- Reloads on /rl command
  self:RegisterChatCommand("feed", "OpenConfigMenu")
  self:RegisterChatCommand("fmo", "OpenConfigMenu")
  self:RegisterChatCommand("fff", function() Feed_Me:Timer() end)
  Feed_Me:Timer()
  button:Hide()
end

function Feed_Me:ShowButton()
  button:Show()
  button:SetText("Feed Pet")
  button:SetNormalTexture("Interface\\Icons\\INV_Misc_Food_59")
end

function Feed_Me:OpenConfigMenu()
  InterfaceOptionsFrame_OpenToCategory("Feed_Me")
end

function Feed_Me:Start()
  print("no")
end

function Feed_Me:FindFood(petName, diet)
  -- For each pet's diet, find the corresponding food items in your inventory
  print(petName, diet, "test")
  if diet then
    for _, foodType in ipairs(diet) do
      for _, foodItem in ipairs(foodTypes[foodType]) do
        local count = GetItemCount(foodItem)
        if count > 0 then
          print(petName .. " likes " .. foodItem .. " and you have " .. count .. " of them in your inventory.")
        end
      end
    end
  end
end

function Feed_Me:FindBestFoodItem(petName, diet)
  local bestFoodItem = nil
  local bestFoodCount = 0
  for _, foodType in ipairs(diet) do
    for _, foodItem in ipairs(foodTypes[foodType]) do
      local count = GetItemCount(foodItem)
      if count > bestFoodCount then
        bestFoodItem = foodItem
        bestFoodCount = count
      end
    end
  end
  return bestFoodItem
end

function Feed_Me:FeedPet()
  if UnitExists("pet") then
    local petIcon, petName, petLevel, petType, petLoyalty = GetStablePetInfo(0)
    local diet = petDiets[petType]
    local bestFoodItem = Feed_Me:FindBestFoodItem(petName, diet)
    if bestFoodItem then
      CastSpellByName("Feed Pet")
      UseItemByName(bestFoodItem)
    end
  end
end

function Feed_Me:Ticker()
  if UnitExists("pet") then
    local petIcon, petName, petLevel, petType, petLoyalty = GetStablePetInfo(0)
    local happiness = GetPetHappiness()
    -- Get the diet of the pet
    local diet = petDiets[petType]
    local bestFoodItem = Feed_Me:FindBestFoodItem(petName, diet)
    if (happiness == 1) then
      print(petName, ": FEED ME YOU MONSTER!")
      if bestFoodItem then
        -- CastSpellByName("Feed Pet")
        -- UseItemByName(bestFoodItem)
      end
    elseif (happiness == 2) then
      print(petName, ": FEED ME!")
      if bestFoodItem then
        -- CastSpellByName("Feed Pet")
        -- UseItemByName(bestFoodItem)
      end
    end
    Feed_Me:ShowButton()
  end
end

function Feed_Me:Timer()
  -- local ticker = C_Timer.NewTicker(1, Feed_Me.Ticker)
  --debug:
  Feed_Me:Ticker()
end
