-- Changes Wee Joker to a Unique Sprite
-- Depends on LibSprite
-- art by efhiii

libSprite = getLibSprite()
patched = false
table.insert(mods,
  {
    mod_id = "unique_wee",
    name = "Unique Wee Joker",
    author = "JoStro (art by efhiii)",
    version = "0.1",
    enabled = true,
    on_enable = function()
    end,
    on_post_update = function()
      if not patched then
        libSprite.addAtlas("Wee","wee.png",45,59)
        G.P_CENTERS.j_wee.atlas = "Wee"
        sendDebugMessage(G.ASSET_ATLAS["Wee"])
        patched = true
      end
    end,
  }
)
