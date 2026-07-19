local data_util = require("__Krastorio2-spaced-out__.data-util")





local function add_recipe_category(recipe, category)
  recipe.categories = recipe.categories or {"crafting"}
  table.insert(recipe.categories, category)
end

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

if settings.startup["krt-bio-processing-em"].value then add_recipe_category(data.raw["recipe"]["kr-bio-processing-circuit"], "electromagnetics") end

add_recipe_category(data.raw.recipe["kr-ai-core"], "electromagnetics")


local function change_ingredient(recipe_name, ingredient_name, new_ingredient)
        local recipe = data.raw.recipe[recipe_name]
        for i, ingredient in pairs(recipe.ingredients) do
            if ingredient.name == ingredient_name then
                ingredient = new_ingredient
                return
            end
        end
    end


-- data_util.add_or_replace_ingredient("recycler", "kr-rare-metals", { type = "item", name = "steel-plate", amount = 20 })
data.raw.item["kr-quantum-computer"].default_import_location = "aquilo"

if mods["sushi-splitters"] then
    data.raw.recipe["sushi-express-splitter-upgrade"].main_product = nil
end

data.raw["item"]["tree-seed"].stack_size = 1000
data.raw["item"]["yumako-seed"].stack_size = 1000
data.raw["item"]["jellynut-seed"].stack_size = 1000

data.raw["item"]["tree-seed"].weight = 0.1 * kg
data.raw["item"]["yumako-seed"].weight = 0.1 * kg
data.raw["item"]["jellynut-seed"].weight = 0.1 * kg

if mods ["ev-refining"] then
    data:extend({
        {
            type = "recipe",
            name = "rare-metals-ore-alternative-enriching",
            localised_name = "Molten ore (rare-metals) - Alternative enriching\nEfficiency: 3.0x",
            icon = "__k2-tweaks__/graphics/icons/rare-metals-ore-alternative-enriching.png",
            icon_size = 64,
            categories = {"enriching1"},
            subgroup = "ev-vulcanus-processes",
            order = "aa",
            allow_productivity = true,
            enabled = false,
            energy_required = 16,
            ingredients =
            {
                { type = "item", name = "kr-rare-metal-ore", amount = 20 },
                { type = "item", name = "calcite", amount = 1 }
            },
            results =
            {
                { type = "fluid", name = "kr-molten-rare-metals", amount = 400},
            }
        }
    })
    table.insert(data.raw.technology["elite-ore-processing"].effects, {type = "unlock-recipe", recipe = "rare-metals-ore-alternative-enriching"})
end
if mods["god-module"] then
    data_util.add_or_replace_ingredient("god-module-speed", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-efficiency", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-productivity", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-quality", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
end

table.insert(data.raw["reactor"]["heating-tower"]["energy_source"]["fuel_categories"],"kr-vehicle-fuel")