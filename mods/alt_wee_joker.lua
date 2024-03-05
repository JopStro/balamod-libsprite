-- Changes Wee Joker to a Unique Sprite
-- Depends on LibSprite
-- art by efhiii
entry = ""
libSprite = getLibSprite()
table.insert(mods,
  {
    mod_id = "unique_wee",
    name = "Unique Wee Joker",
    author = "JoStro (art by efhiii)",
    version = "0.2",
    enabled = true,
    on_enable = function()
        entry = libSprite.addAtlas("Wee","wee.png",45,59)
        G.P_CENTERS.j_wee.atlas = "Wee"
    end,
    on_disable = function()
        libSprite.removeAtlas(entry)
        G.P_CENTERS.j_wee.atlas = nil
    end,
  }
)
