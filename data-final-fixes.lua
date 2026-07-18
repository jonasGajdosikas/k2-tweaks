local data_util = require("__Krastorio2-spaced-out__.data-util")

-- tweak underground belt lengths so you can remove a pair of undergrounds when upgrading
if settings.startup["krt-belt-length-tweaks"].value then
    data.raw["underground-belt"]["fast-underground-belt"].max_distance = 11
    data.raw["underground-belt"]["express-underground-belt"].max_distance = 17
    data.raw["underground-belt"]["turbo-underground-belt"].max_distance = 23
    data.raw["underground-belt"]["kr-superior-underground-belt"].max_distance = 47
end

-- tweak the advanced pickaxe tech to be a trigger instead of a research
data.raw["technology"]["kr-advanced-pickaxe"].prerequisites = { "steel-axe", "kr-imersium-processing" }
data.raw["technology"]["kr-advanced-pickaxe"].unit = nil
data.raw["technology"]["kr-advanced-pickaxe"].research_trigger = {
			type = "craft-item",
			item = "kr-imersium-plate",
			count = 200,
		}


-- tweak loaders and inserters
data.raw["loader-1x1"]["kr-loader"].heating_energy = "50kW"
data.raw["loader-1x1"]["kr-fast-loader"].heating_energy = "100kW"
data.raw["loader-1x1"]["kr-express-loader"].heating_energy = "150kW"
data.raw["loader-1x1"]["kr-advanced-loader"].heating_energy = "200kW"
data.raw["loader-1x1"]["kr-superior-loader"].heating_energy = "250kW"

data.raw["storage-tank"]["kr-big-storage-tank"].heating_energy = "200kW"
data.raw["storage-tank"]["kr-huge-storage-tank"].heating_energy = "400kW"

data.raw["inserter"]["kr-superior-inserter"].max_belt_stack_size = 4
data.raw["inserter"]["kr-superior-long-inserter"].max_belt_stack_size = 4


-- return of the bio processing unit

if settings.startup["krt-bio-processing-em"].value then data.raw["recipe"]["kr-bio-processing-circuit"].additional_categories = { "electronics" } end

data.raw.recipe["kr-ai-core"].additional_categories = {"electronics"}


local function change_ingredient(recipe_name, ingredient_name, new_ingredient)
        local recipe = data.raw.recipe[recipe_name]
        for i, ingredient in pairs(recipe.ingredients) do
            if ingredient.name == ingredient_name then
                ingredient = new_ingredient
                return
            end
        end
    end


data_util.add_or_replace_ingredient("recycler", "kr-rare-metals", { type = "item", name = "steel-plate", amount = 20 })
data.raw.item["kr-quantum-computer"].default_import_location = "aquilo"



--[[
local types = {
	"technology",
	"recipe",
	"item",
	"assembling-machine",
	"unit",
	"item-with-entity-data",
	"capsule",
	"fish",
	"turret",
	"locomotive",
	"unit-spawner",
	"corpse",
	"ammo",
	"armor",
	"reactor",
	"resource",
	"pipe-to-ground",
	"splitter",
	"underground-belt",
	"transport-belt",
}
-- restore personal battery mk3
--- @param what Name
function  unhide(what)
    for _, type in pairs(types) do
        local prototype = data.raw[type][what]
        if prototype then
            prototype.hidden = false
            prototype.hidden_in_factoriopedia = false
        end
    end
end


    unhide("kr-battery-mk3-equipment")
    data:extend({
        {
            type = "technology",
            name = "kr-battery-mk3-equipment",
            icon_size = 256,
            icons = util.technology_icon_constant_equipment("__Krastorio2Assets__/technologies/battery-mk3-equipment.png"),
            upgrade = false,
            unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
            },
            time = 60,
            },
            prerequisites = { "kr-quarry-minerals-extraction", "kr-lithium-sulfur-battery", "battery-mk2-equipment" },
            effects = {
            { type = "unlock-recipe", recipe = "kr-battery-mk3-equipment" },
            { type = "unlock-recipe", recipe = "kr-big-battery-mk3-equipment" },
            },
        }
    })
--]]