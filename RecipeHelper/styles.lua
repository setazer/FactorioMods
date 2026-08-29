-- RecipeHelper: GUI styles (data stage).
-- Adds styles into the vanilla default gui-style table.

local styles = data.raw["gui-style"].default

styles["rh_toggle_button"] = {
  type = "button_style",
  parent = "green_button",
  size = 40,
  padding = 0,
}

styles["rh_panel"] = {
  type = "frame_style",
  parent = "frame",
  width = 440,
  vertically_stretchable = "off",
}

styles["rh_search"] = {
  type = "textbox_style",
  width = 180,
  left_margin = 4,
}

styles["rh_tabs_flow"] = {
  type = "horizontal_flow_style",
  horizontally_wrappable = "wrap",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  bottom_padding = 4,
}

styles["rh_tab_button"] = {
  type = "button_style",
  parent = "button",
  size = 40,
  padding = 2,
  clicked_vertical_offset = 0,
}

-- Selected tab: vanilla "pressed button" look (same tile the chooser tabs use).
styles["rh_tab_button_selected"] = {
  type = "button_style",
  parent = "slot_sized_button_pressed",
  size = 40,
  padding = 2,
  clicked_vertical_offset = 0,
}

-- Dimmed tab (vanilla search behavior): dark bg + black & white icon.
styles["rh_tab_button_dimmed"] = {
  type = "button_style",
  parent = "slot",
  size = 40,
  padding = 2,
  clicked_vertical_offset = 0,
  grayscale_picture = true,
}

-- Red "Nothing found" plate: vanilla negative_message_frame (tile {403,17}
-- of gui-new.png, the color sampled as #542929) + white bold label.
styles["rh_not_found_plate"] = {
  type = "frame_style",
  parent = "negative_message_frame",
  horizontally_stretchable = "on",
  top_padding = 8,
  bottom_padding = 8,
  left_padding = 8,
  right_padding = 8,
}

styles["rh_not_found_label"] = {
  type = "label_style",
  parent = "bold_label",
  font_color = {1, 1, 1},
  horizontally_stretchable = "on",
  horizontal_align = "center",
}

styles["rh_grid_scroll"] = {
  type = "scroll_pane_style",
  height = 480,
  vertical_scroll_policy = "auto",
  horizontally_stretchable = "on",
}

-- Vertical container for subgroup rows.
styles["rh_grid_flow"] = {
  type = "vertical_flow_style",
  vertically_stretchable = "on",
  horizontally_stretchable = "on",
  vertical_spacing = 1,
  top_padding = 4,
}

-- One table per recipe subgroup: the table element does the grid layout
-- natively (column_count = 10), like the vanilla slot_table.
styles["rh_recipe_table"] = {
  type = "table_style",
  parent = "slot_table",
  horizontal_spacing = 1,
  vertical_spacing = 1,
  horizontal_padding = 0,
  vertical_padding = 0,
  top_padding = 0,
  bottom_padding = 0,
  left_padding = 0,
  right_padding = 0,
}

styles["rh_recipe_button"] = {
  type = "button_style",
  parent = "slot_button",
  size = 40,
  padding = 0,
}

-- Selection highlight: vanilla yellow_slot_button (same geometry as
-- slot_button, no icon size change). Same pair as FilterHelper uses.
styles["rh_recipe_button_selected"] = {
  type = "button_style",
  parent = "yellow_slot_button",
  size = 40,
  padding = 0,
  clicked_vertical_offset = 0,
}

-- Quality picker row at the bottom of the panel.
styles["rh_quality_row"] = {
  type = "horizontal_flow_style",
  vertical_align = "center",
  horizontal_spacing = 0,
  top_padding = 8,
}

styles["rh_quality_button"] = {
  type = "button_style",
  parent = "button",
  size = 28,
  padding = 0,
}

-- Selected quality: vanilla green button (confirm-like), same geometry.
styles["rh_quality_button_selected"] = {
  type = "button_style",
  parent = "green_button",
  size = 28,
  padding = 0,
  clicked_vertical_offset = 0,
}
