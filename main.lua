local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Test GUI"})
local Tab = Window:MakeTab({Name = "Main"})
Tab:AddButton({Name = "Test Button", Callback = function() print("Button pressed!") end})
