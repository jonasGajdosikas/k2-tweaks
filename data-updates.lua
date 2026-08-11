-- make the t3 modules use spage recipes again
if settings.startup["krt-spage-modules"].value then
    local function change_ingredient_amount(recipe_name, ingredient_name, amount)
        local recipe = data.raw.recipe[recipe_name]
        for i, ingredient in pairs(recipe.ingredients) do
            if ingredient.name == ingredient_name then
                ingredient.amount = amount
                return
            end
        end
        local recycling_recipe = data.raw.recipe[recipe_name .. "-recycling"]
        for i, output in pairs(recycling_recipe.results) do
            if output.name == ingredient_name then
                output.amount = amount / 4
                output.extra_count_fraction = (amount % 4) / 4.0
            end
        end
    end

    data.raw.recipe["efficiency-module-2"].energy_required = 30
    --change_ingredient_amount("efficiency-module-2", "efficiency-module", 4)
    data.raw.recipe["efficiency-module-3"].energy_required = 60
    --change_ingredient_amount("efficiency-module-3", "efficiency-module-2", 4)
    --table.insert(data.raw.recipe["efficiency-module-3"].ingredients, {type = "item", name = "spoilage", amount = 5})
    --table.insert(data.raw.recipe["efficiency-module-3-recycling"].results, {type = "item", name = "spoilage", amount = 1, extra_count_fraction = 0.25})

    data.raw.recipe["quality-module-2"].energy_required = 30
    --change_ingredient_amount("quality-module-2", "quality-module", 4)
    data.raw.recipe["quality-module-3"].energy_required = 60
    --change_ingredient_amount("quality-module-3", "quality-module-2", 4)
    --table.insert(data.raw.recipe["quality-module-3"].ingredients,{ type = "item", name = "superconductor", amount = 1 })
    --table.insert(data.raw.recipe["quality-module-3-recycling"].results, {type = "item", name = "superconductor", amount = 0, extra_count_fraction = 0.25})

    data.raw.recipe["productivity-module-2"].energy_required = 30
    --change_ingredient_amount("productivity-module-2", "productivity-module", 4)
    data.raw.recipe["productivity-module-3"].energy_required = 60
    --change_ingredient_amount("productivity-module-3", "productivity-module-2", 4)
    --table.insert(data.raw.recipe["productivity-module-3"].ingredients,{ type = "item", name = "biter-egg", amount = 1 })
    --table.insert(data.raw.recipe["productivity-module-3-recycling"].results, {type = "item", name = "biter-egg", amount = 0, extra_count_fraction = 0.25})

    data.raw.recipe["speed-module-2"].energy_required = 30
    --change_ingredient_amount("speed-module-2", "speed-module", 4)
    data.raw.recipe["speed-module-3"].energy_required = 60
    --change_ingredient_amount("speed-module-3", "speed-module-2", 4)
    --table.insert(data.raw.recipe["speed-module-3"].ingredients,{ type = "item", name = "tungsten-carbide", amount = 1 })
    --table.insert(data.raw.recipe["speed-module-3-recycling"].results, {type = "item", name = "tungsten-carbide", amount = 0, probaextra_count_fractionbility = 0.25})
end
if mods["ev-refining"] then
    data.raw.recipe["coal-chunk-enrichment"].auto_recycle = true
end
data.raw.recipe["hazard-concrete"].recycle_to_ingredients_of = nil
data.raw.recipe["refined-hazard-concrete"].recycle_to_ingredients_of = nil

local function remove_quality_chance(recipe, output)
    local recipe_table = data.raw.recipe[recipe]
    if recipe_table == nil then return end
    for i, item in pairs(recipe_table.results) do
        if item.name == output then
            item.affected_by_quality = false
        end
    end
end

remove_quality_chance("kr-singularity-tech-card", "kr-matter-stabilizer")
remove_quality_chance("kr-singularity-tech-card-cooling", "kr-matter-stabilizer")
