
function getLibSprite() 
    return {
        addAtlas = function(name, path, px, py)
            fullPath = "resources/"..G.SETTINGS.GRAPHICS.texture_scaling.."x/"..path
            G.ASSET_ATLAS[name] = {}
            G.ASSET_ATLAS[name].name = name
            G.ASSET_ATLAS[name].image = love.graphics.newImage(fullPath, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})
            G.ASSET_ATLAS[name].px = px
            G.ASSET_ATLAS[name].py = py
            
        end,
        removeAtlas = function(name)
            G.ASSET_ATLAS[name] = nil
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
        -- on_disable = function()
        --     inject("card.lua", "Card:set_sprites", set_sprites_replacment:gsub("([^%w])", "%%%1"), set_sprites_target)
        -- end,
    }
)
