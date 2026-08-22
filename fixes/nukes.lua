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