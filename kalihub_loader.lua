-- KaLiHub Loader (Stable Version)

print("[KaLiHub] Loader started")

local REPO = "[https://raw.githubusercontent.com/JIBA12/kali/main/](https://raw.githubusercontent.com/JIBA12/kali/main/)"

-- Wait for game
if not game:IsLoaded() then
game.Loaded:Wait()
end

-- Test HttpGet first
local function fetch(url)
local success, result = pcall(function()
return game:HttpGet(url)
end)
if success then
return result
else
warn("[KaLiHub] Failed to load:", url)
return nil
end
end

-- Try loading Jnkie (optional)
local Junkie
local ok, err = pcall(function()
Junkie = loadstring(game:HttpGet("[https://jnkie.com/sdk/library.lua"))(](https://jnkie.com/sdk/library.lua%22%29%29%28))
end)

if ok and Junkie then
print("[KaLiHub] Jnkie loaded")
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

```
-- Check existing key
if getgenv().SCRIPT_KEY then
    local result = Junkie.check_key(getgenv().SCRIPT_KEY)
    if result and result.valid then
        print("[KaLiHub] Key valid, loading hub")
        local hub = fetch(REPO .. "kalihub.lua")
        if hub then loadstring(hub)() end
        return
    end
end
```

else
warn("[KaLiHub] Jnkie failed to load, continuing without pre-check")
end

-- Load Key GUI
print("[KaLiHub] Loading Key GUI")
local keygui = fetch(REPO .. "keygui.lua")
if keygui then
loadstring(keygui)()
else
warn("[KaLiHub] Key GUI failed to load")
end
