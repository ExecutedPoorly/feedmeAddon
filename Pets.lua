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
function GetBestFood(speciesType)
  local matchingDiets = petDiets[speciesType]
 
  -- Get the item with the largest matching number in the bags
  local bestFood = nil
  local maxCount = 0
  for _, foodType in ipairs(matchingDiets) do
    local foods = foodTypes[foodType]
    for _, food in ipairs(foods) do
      local count = GetItemCount(food)
      -- print(food, count)
      if count > maxCount then
        bestFood = food
        maxCount = count
        -- print(maxCount, bestFood, "debug")
      end
    end
  end

  if bestFood then
    -- print("The best food for the pet is: " .. bestFood .. " " .. maxCount)
  else
    -- print("No matching vendor food was found for the pet.")
  end
 
  -- Return the best food
  return bestFood
 end


