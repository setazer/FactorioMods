-- RecipeHelper: mod settings.

data:extend({
  {
    type = "bool-setting",
    name = "rh-remember-quality",
    setting_type = "runtime-per-user",
    default_value = false,
    order = "a",
  },
  {
    type = "bool-setting",
    name = "rh-show-button",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "b",
  },
  {
    type = "bool-setting",
    name = "rh-replace-pickers",
    setting_type = "runtime-per-user",
    default_value = true,
    order = "c",
  },
})
