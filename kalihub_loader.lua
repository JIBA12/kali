-- KaLiHub Secure Loader
if getgenv().KaLiHub_Loaded then return end
getgenv().KaLiHub_Loaded = true

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Jnkie SDK
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "KaLiHubV3"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

-- Helper to load scripts from GitHub
local function loadScript(path)
    loadstring(game:HttpGet(path))()
end

-- Check preset key
if getgenv().SCRIPT_KEY then
    if Junkie.check_key(getgenv().SCRIPT_KEY).valid then
        loadScript("https://raw.githubusercontent.com/JIBA12/kali/main/kalihub.lua")
        return
    end
end

-- Check saved key
if readfile and isfile and isfile("KaLiHub_Key.txt") then
    local savedKey = readfile("KaLiHub_Key.txt")
    if Junkie.check_key(savedKey).valid then
        getgenv().SCRIPT_KEY = savedKey
        loadScript("https://raw.githubusercontent.com/JIBA12/kali/main/kalihub.lua")
        return
    end
end

-- No valid key → load key GUI
loadScript("https://raw.githubusercontent.com/JIBA12/kali/main/keygui.lua")
