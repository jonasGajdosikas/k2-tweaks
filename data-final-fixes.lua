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


if mods["lane-balancers"] then
    local function fix_recipe(config)
        local splitter = data.raw["recipe"][config.prefix .. "splitter"]
        local balancer = table.deepcopy(splitter)

        balancer.name = config.prefix .. "lane-splitter"
        balancer.main_product = config.prefix .. "lane-splitter"

        if config.previous_prefix then
            for _, ingredient in ipairs(balancer.ingredients) do
                if ingredient.name == config.previous_prefix .. "splitter" then
                    ingredient.name = config.previous_prefix .. "lane-splitter"
                    ingredient.amount = 2
                end
            end
        end

        balancer.results[1].name = config.prefix .. "lane-splitter"
        balancer.results[1].amount = 2

        data.raw.recipe[config.prefix .. "lane-splitter"] = balancer
    end

    fix_recipe({prefix = "", previous_prefix = "n/a"})
    fix_recipe({prefix = "fast-", previous_prefix = ""})
    fix_recipe({prefix = "express-", previous_prefix = "fast-"})
    fix_recipe({prefix = "turbo-", previous_prefix = "express-"})
    fix_recipe({prefix = "kr-superior-", previous_prefix = "turbo-"})
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
add_recipe_category(data.raw.recipe["kr-singularity-beacon"], "electromagnetics")
data.raw.item["kr-singularity-beacon"].stack_size = 10
data.raw.item["kr-singularity-beacon"].weight = 100 * kg

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

    data.raw.recipe["copper-dust-smelting"].allow_decomposition = false
    data.raw.recipe["iron-dust-smelting"].allow_decomposition = false
    data.raw.recipe["tungsten-dust-smelting"].allow_decomposition = false
    data.raw.recipe["rare-metals-dust-smelting"].allow_decomposition = false
end
if mods["god-module"] then
    data_util.add_or_replace_ingredient("god-module-speed", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-efficiency", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-productivity", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-quality", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
end

-- let me use hydrogen for fuel on aquilo goddangit
table.insert(data.raw["reactor"]["heating-tower"]["energy_source"]["fuel_categories"],"kr-vehicle-fuel")

if settings.startup["krt-holmium-to-lithium"] then
    local lithium_recipe = data.raw.recipe["lithium"]
	if (lithium_recipe) then
		local existing_holmium = false
        for _, ingredient in ipairs(lithium_recipe.ingredients) do
            if ingredient.name == "holmium-plate" then
                existing_holmium = true
                break
            end
        end
		if (not existing_holmium) then
            local lithium_crystal = table.deepcopy(lithium_recipe)
			lithium_crystal.name = "krt-lithium-crystallization"
            lithium_crystal.localised_name = "Lithium crystallization on holmium"
            lithium_crystal.main_product = "kr-lithium"
            table.insert(lithium_crystal.ingredients, { type = "item", name = "holmium-plate", amount = 1, ignored_by_stats = 1})
            table.insert(lithium_crystal.results, {type = "item", name = "holmium-plate", amount = 1, ignored_by_stats = 1, independent_probability = 0.8, affected_by_quality = false})
            data:extend({lithium_crystal})
		end
	end
end