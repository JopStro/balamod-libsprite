
local fresh = false
function getLibSprite() 
    return {
        addAtlas = function(name, path, px, py)
            fullPath = "\"textures/\"..self.SETTINGS.GRAPHICS.texture_scaling..\"x/"..path:gsub("([\\\"])","\\%1").."\""
            entry = string.format("{name = \"%s\",path = %s,px=%d,py=%d},\n",
                name:gsub("([\\\"])","\\%1"), fullPath, px, py
            )
            target = "self.asset_atli = {\n"
            inject("game.lua", "Game:set_render_settings", target, target..entry)
            fresh = false
            return entry
        end,
        removeAtlas = function(entry)
            inject("game.lua", "Game:set_render_settings", entry, "")
            fresh = false
        end,
    }
end

local targets = {
    "elseif _center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher' then",
    "G.ASSET_ATLAS['Joker'], self.config.center.soul_pos",
}
local replacements = {
    "elseif (_center.set == 'Joker' or _center.consumeable or _center.set == 'Voucher') and not _center.atlas then",
    "G.ASSET_ATLAS[_center.atlas or 'Joker'], self.config.center.soul_pos",
}

table.insert(mods,
    {
        mod_id = "libsprite",
        name = "LibSprite",
        author = "JoStro",
        version = "0.2",
        enabled = true,
        on_enable = function()
            for i = 1, #targets do
                sendDebugMessage("injecting "..i)
                inject("card.lua", "Card:set_sprites", targets[i]:gsub("([^%w])","%%%1"), replacements[i])
            end
        end,
        on_disable = function()
            for i = 1, #targets do
                inject("card.lua", "Card:set_sprites", replacements[i]:gsub("([^%w])","%%%1"), targets[i])
            end
        end,
        on_post_update = function()
            if not fresh then
                G:set_render_settings()
                fresh = true
            end
        end,
    }
)
