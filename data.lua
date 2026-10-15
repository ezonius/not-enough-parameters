-- Creates 26 additional blueprint parameters (parameter-a .. parameter-z),
-- cloning the vanilla parameter prototypes (parameter-1) exactly like base does
-- in base/prototypes/item.lua, fluid.lua, recipe.lua and entity/entities.lua.

local ALPHABET = "abcdefghijklmnopqrstuvwxyz"
local MOD_NAME = "not-enough-parameters"

-- The prototype types that vanilla uses for blueprint parameters, and the
-- prototype of each type we clone from.
local PARAMETER_TYPES = { "item", "fluid", "recipe", "simple-entity" }

-- Grab the vanilla prototypes once, up front, so a missing prototype fails
-- loudly with a readable message instead of a cryptic nil error deep in
-- table.deepcopy on the 18th loop iteration.
local vanilla_parameters = {}
for _, prototype_type in ipairs(PARAMETER_TYPES) do
	local prototype = data.raw[prototype_type] and data.raw[prototype_type]["parameter-1"]
	if not prototype then
		error("[" .. MOD_NAME .. "] Vanilla prototype '" .. prototype_type .. ".parameter-1' not found. " ..
			"This mod clones it to create extra blueprint parameters and cannot work without it. " ..
			"Please check your base game version.")
	end
	vanilla_parameters[prototype_type] = prototype
end

local new_prototypes = {}

for c in ALPHABET:gmatch"." do
	local letter = c:upper()
	for _, prototype_type in ipairs(PARAMETER_TYPES) do
		local temp = table.deepcopy(vanilla_parameters[prototype_type])

		temp.name = "parameter-" .. c
		temp.icon = "__" .. MOD_NAME .. "__/graphics/parameter-" .. c .. ".png"
		-- Locale keys "parameter-x" and "entity-description.parameter-x" come from
		-- base, same as vanilla parameter-0..9 uses ("Parameter __1__").
		temp.localised_name = { "parameter-x", letter }

		-- Explicit per-letter sort order. Sorting is lexicographic on the order
		-- string. "parameter-z" + letter sorts after other mods' numeric orders
		-- (e.g. still-not-enough-parameters "parameter-z10".."parameter-z99",
		-- since digits compare before letters), giving this stable order in the
		-- pickers:
		--   vanilla 0-9 (order "a") -> 10-99 ("parameter-z10".."parameter-z99")
		--   -> letters A-Z ("parameter-za".."parameter-zz")
		temp.order = "parameter-z" .. c

		new_prototypes[#new_prototypes + 1] = temp
	end
end

data:extend(new_prototypes)
