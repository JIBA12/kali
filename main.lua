-- Ensure HTTP requests are enabled in Roblox Studio settings before running

-- Load Hattori V4 UI library
local HttpService = game:GetService("HttpService")
local Success, Hattori = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Hattori/V4/source.lua"))()
end)

if not Success then
    warn("Failed to load Hattori V4: " .. tostring(Hattori))
    return
end

-- Create the main window
local Window = Hattori:Window({
    Name = "KaLi Hub",
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark"
})

-- Example: Add a tab
local Tab = Window:Tab("Main")
Tab:Button({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})
