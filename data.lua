local alphabet = "abcdefghijklmnopqrstuvwxyz"

for c in alphabet:gmatch"." do
    local temp_item = table.deepcopy(data.raw["item"]["parameter-1"])
    local temp_fluid = table.deepcopy(data.raw["fluid"]["parameter-1"])
    local temp_recipe = table.deepcopy(data.raw["recipe"]["parameter-1"])
    local temp_simple_entity = table.deepcopy(data.raw["simple-entity"]["parameter-1"])

    temp_item.name = "parameter-"..c
    temp_fluid.name = "parameter-"..c
    temp_recipe.name = "parameter-"..c
    temp_simple_entity.name = "parameter-"..c

    temp_item.icon = "__not-enough-parameters__/graphics/parameter-"..c..".png"
    temp_fluid.icon = "__not-enough-parameters__/graphics/parameter-"..c..".png"
    temp_recipe.icon = "__not-enough-parameters__/graphics/parameter-"..c..".png"
    temp_simple_entity.icon = "__not-enough-parameters__/graphics/parameter-"..c..".png"

    temp_item.localised_name = {"parameter-x", c:upper()}
    temp_fluid.localised_name = {"parameter-x", c:upper()}
    temp_recipe.localised_name = {"parameter-x", c:upper()}
    temp_simple_entity.localised_name = {"parameter-x", c:upper()}

    data:extend{temp_item, temp_fluid, temp_recipe, temp_simple_entity}
end
