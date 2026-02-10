local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "KaLi Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "KaLiHub"})

local Tab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://6034818375", PremiumOnly = false})

Tab:AddButton({
    Name = "Do Action",
    Callback = function()
        print("Button pressed")
    end
})

Tab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Toggle state:", state)
    end
})

Tab:AddSlider({
    Name = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Slider:", value)
    end
})
