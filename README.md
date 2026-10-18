# Not Enough Parameters

Gives you an additional **26 blueprint parameters — one for each letter of the English alphabet**
(`parameter-a` … `parameter-z`), on top of the vanilla 0-9.

## How it works

- For each letter, clones the vanilla `parameter-1` prototypes across all parameter prototype types
  (item, fluid, recipe, simple-entity) — exactly the way base game defines its own parameters.
- Uses base's localisation keys (`parameter-x`), so names/descriptions render as
  "Parameter A" … "Parameter Z" with custom A-Z icons.
- If a vanilla `parameter-1` prototype is missing, the mod fails **up front with a readable error** instead
  of a cryptic crash deep inside `table.deepcopy`.

## Sorting / compatibility

Letter parameters get an explicit prefixed sort order (`parameter-za` … `parameter-zz`), so the pickers
sort deterministically as:

1. vanilla 0-9 (`order "a"`)
2. [still-not-enough-parameters](https://mods.factorio.com/mod/still-not-enough-parameters) 10-99
   (`parameter-z10` … `parameter-z99` — digits compare before letters)
3. this mod's A-Z

Factorio **2.1**.
