--install this on a server or a friend's game as a joke
local texture_change = 1 --0 dirt, 1 random colors, 2 clouds

local mod_storage = minetest.get_mod_storage() --initialize mod storage

--make this optional for true modularity
local depends_string = "optional_depends = " --create empty file list

--go through all installed mods
for _,modname in pairs(minetest.get_modnames()) do
  if modname ~= minetest.get_current_modname() then
    depends_string = depends_string .. modname .. ","
  end
end

depends_string = depends_string:sub(1, -2) -- remove the last comma off the end

--print(depends_string)

--minetest.safe_file_write(minetest.get_modpath("item_limit").."/mod.conf", depends_string)

--update the dependancies if needed

if mod_storage:get_string("depends") == "" then
    mod_storage:set_string("depends", depends_string)
    minetest.safe_file_write(minetest.get_modpath(minetest.get_current_modname()).."/mod.conf", depends_string)
else
    --if no change tell
    if mod_storage:get_string("depends") == depends_string then
      --nil
    --if added mod, update
    else
      mod_storage:set_string("depends", depends_string)
      minetest.safe_file_write(minetest.get_modpath(minetest.get_current_modname()).."/mod.conf", depends_string)
    end
end

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
