--install this on a server or a friend's game as a joke
local texture_change = 1 --0 dirt, 1 random colors, 2 clouds

minetest.register_on_mods_loaded(function()
  --set everything to clouds
  local colorwheel = {"red", "orange", "yellow", "green", "blue", "indigo", "violet"}

  --just make everything ridiculous
  for i,a in pairs(minetest.registered_items) do
    if texture_change == 1 then
      local colortable = {}
      for i = 1,10 do
        colortable[i] = "color_world_"..colorwheel[math.random(1,7)]..".png"
      end
      minetest.override_item(a.name,
      {
    	tiles = colortable,
      })
    elseif texture_change == 0 then
      minetest.override_item(a.name,
      {
    	tiles = {"default_dirt.png",},
      })
    elseif  texture_change == 2 then
      minetest.override_item(a.name,
      {
    	tiles = {"default_cloud.png"},
      })
    end
  end
end)
