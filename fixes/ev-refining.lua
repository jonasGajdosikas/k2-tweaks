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