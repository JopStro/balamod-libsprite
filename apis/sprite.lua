
fresh = false
function getLibSprite() 
    return {
        addAtlas = function(name, path, px, py)
            fullPath = "\"textures/\"..self.SETTINGS.GRAPHICS.texture_scaling..\"x/"..path:gsub("([\\\"])","\\%1").."\""
            entry = string.format("{name = \"%s\",path = %s,px=%d,py=%d},\n",
                name:gsub("([\\\"])","\\%1"), fullPath, px, py
            )
            target = "self.asset_atli = {\n"
            inject("game.lua", "Game:set_render_settings", target:gsub("([^%w])", "%%%1"), target..entry)
            fresh = false
            return entry
        end,
        removeAtlas = function(entry)
            inject("game.lua", "Game:set_render_settings", entry:gsub("([^%w])", "%%%1"), "")
            fresh = false
        end,
    }
end

-- Allows Jokers to have custom atlases
set_sprites_target = "elseif _center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher' then"
set_sprites_replacment = "elseif (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and not _center.atlas then"

table.insert(mods,
    {
        mod_id = "libsprite",
        name = "LibSprite",
        author = "JoStro",
        version = "0.1",
        enabled = true,
        on_enable = function()
            inject("card.lua", "Card:set_sprites", set_sprites_target:gsub("([^%w])", "%%%1"), set_sprites_replacment)
        end,
        on_disable = function()
            inject("card.lua", "Card:set_sprites", set_sprites_replacment:gsub("([^%w])", "%%%1"), set_sprites_target)
        end,
        on_post_update = function()
            if not fresh then
                G:set_render_settings()
                fresh = true
            end
        end,
    }
)
