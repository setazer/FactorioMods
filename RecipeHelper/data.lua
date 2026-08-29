-- data stage
-- Registers custom inputs used to cycle recipe quality with the mouse wheel.
-- Both are rebindable in the vanilla controls settings.

require("styles")

local inputs = {
  {
    type = "custom-input",
    name = "rh-wheel-up",
    key_sequence = "ALT + mouse-wheel-up",
    alternative_key_sequence = "SHIFT + mouse-wheel-up",
    consuming = "none",
  },
  {
    type = "custom-input",
    name = "rh-wheel-down",
    key_sequence = "ALT + mouse-wheel-down",
    alternative_key_sequence = "SHIFT + mouse-wheel-down",
    consuming = "none",
  },
}

data:extend(inputs)
