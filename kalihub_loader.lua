-- KaLiHub Secure Loader (Main Branch)

local HttpService = game:GetService("HttpService")

local BASE = "https://raw.githubusercontent.com/JIBA12/kali/main/"

local function LoadScript(name)
    local success, result = pcall(function()
        return game:HttpGet(BASE .. name)
    end)

    if success and result and result ~= "" then
        local func = loadstring(result)
        if func then
            return func()
        else
            warn("KaLiHub: Failed to compile " .. name)
        end
    else
        warn("KaLiHub: Failed to load " .. name)
    end
end

-- Global Key System
getgenv().KaLiHub = {
    Key = "KALI-ACCESS-2026", -- change this to your real key
    Verified = false
}

-- Load Key GUI first
LoadScript("keygui.lua")

-- Wait for verification
repeat task.wait() until getgenv().KaLiHub.Verified == true

-- Load Main Hub
LoadScript("kalihub.lua")
