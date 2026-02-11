-- KaLiHub Secure Loader

local REPO = "https://raw.githubusercontent.com/JIBA12/kali/main/"

-- Load Jnkie
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

-- If key already set, validate it
if getgenv().SCRIPT_KEY then
    local result = Junkie.check_key(getgenv().SCRIPT_KEY)
    if result.valid then
        loadstring(game:HttpGet(REPO .. "kalihub.lua"))()
        return
    end
end

-- Otherwise load key GUI
loadstring(game:HttpGet(REPO .. "keygui.lua"))()
