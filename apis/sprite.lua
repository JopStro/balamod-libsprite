
function getLibSprite() 
    return {
        addAtlas = function(name, path, px, py)
            fullPath = "\"resources/\"..self.GRAPHICS.texture_scaling..\"x/"..path.."\""
            entry = "{name = \""..name.."\", path = "..fullPath..",px="..px..",py="..py.."},"
            target = "selt.asset_atli = {"
            inject("game.lua","Game:set_render_settings",target:gsub("([^%w])", "%%%1"),target.."\n"..entry)
            return entry
        end
        removeAtlas = function(entry)
            inject("game.lua","Game:set_render_settings",entry:gsub("([^%w])", "%%%1"),"")
        end
    }
end

-- Allows Jokers to have custom atlases
set_sprites_target = "elseif _center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher' then"
set_sprites_replacment = "elseif (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and not _center.atlas then"

table.insert(mods,
    {
        mod_id = "libsprite",
        name = "LibSprite",
        author = "JoStro"
        enabled = true,
        on_enable = function()
            inject("card.lua", "Card:set_sprites", set_sprites_target:gsub("([^%w])", "%%%1"), set_sprites_replacement)
        end,
        on_disable = function()
            inject("card.lua", "Card:set_sprites", set_sprites_replacment:gsub("([^%w])", "%%%1"), set_sprites_target)
        end,
    }
)
