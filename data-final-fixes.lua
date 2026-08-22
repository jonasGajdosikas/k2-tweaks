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



data.raw["electric-energy-interface"]["kr-activated-intergalactic-transceiver"].surface_conditions = {}
data.raw["accumulator"]["kr-intergalactic-transceiver"].surface_conditions = {}

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
    require("fixes.ev-refining")
end
if mods["god-module"] then
    data_util.add_or_replace_ingredient("god-module-speed", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-efficiency", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-productivity", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })
    data_util.add_or_replace_ingredient("god-module-quality", "kr-ai-core", { type = "item", name = "kr-ai-core", amount = 5 })

    data.raw["rocket-silo"]["rocket-silo"].allowed_effects = { "consumption", "speed", "productivity", "pollution" }
    table.insert(data.raw["rocket-silo"]["rocket-silo"].allowed_module_categories, "god-modules")
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
            table.insert(data.raw.technology["legendary-quality"].effects, {type = "unlock-recipe", recipe = "krt-lithium-crystallization"})
		end
	end
end

data.raw["assembling-machine"]["captive-biter-spawner"].allowed_effects = {"speed", "consumption"}


local nuke_effects = {"nuke-effects-aquilo","nuke-effects-vulcanus", "nuke-effects-space"}
local nuke_projectiles = {"kr-antimatter-rocket-projectile", "atomic-rocket", "kr-nuclear-turret-rocket-projectile", "kr-matter-turret-rocket-projectile"}
local nuke_arty = {"kr-atomic-artillery-projectile", "kr-antimatter-artillery-projectile"}

for _, projectile in ipairs(nuke_projectiles) do
    -- target index 2, otherwise the lava tiles can remove cliffs first and you'd not get the achievement for cliff destruction.
    for _, effect in ipairs(nuke_effects) do
        table.insert(data.raw.projectile[projectile].action.action_delivery.target_effects, 2, {
            type = "create-entity",
            check_buildability = true,
            entity_name = effect
        })
    end
end

for _, projectile in ipairs(nuke_arty) do
    -- target index 2, otherwise the lava tiles can remove cliffs first and you'd not get the achievement for cliff destruction.
    for _, effect in ipairs(nuke_effects) do
        table.insert(data.raw["artillery-projectile"][projectile].action.action_delivery.target_effects, 2, {
            type = "create-entity",
            check_buildability = true,
            entity_name = effect
        })
    end
end


