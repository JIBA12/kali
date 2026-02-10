--// KaLi Hub - Orion UI Full Version with Circular Icon Notifications
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "KaLi Hub",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "KaLiHub"
})

--// Custom Notification Function (Circular Icon)
local function CircularNotification(name, content, image, time)
    OrionLib:MakeNotification({
        Name = name,
        Content = content,
        Image = image,
        Time = time or 3,
        Callback = function()
            -- Get the most recent notification frame
            local notif = OrionLib.NotificationsContainer:FindFirstChildWhichIsA("Frame", true)
            if notif then
                local icon = notif:FindFirstChild("Icon", true)
                if icon then
                    icon.Size = UDim2.new(0, 30, 0, 30)           -- smaller size
                    icon.BackgroundTransparency = 0
                    icon.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0.5, 0)         -- circular
                    corner.Parent = icon
                end
            end
        end
    })
end

--// Tabs
local MainTab = Window:MakeTab({ Name = "Main", Icon = "rbxassetid://6034818375" })
local SettingsTab = Window:MakeTab({ Name = "Settings", Icon = "rbxassetid://6034818375" })
local AboutTab = Window:MakeTab({ Name = "About", Icon = "rbxassetid://6034818375" })

--// Main Tab
MainTab:AddButton({
    Name = "Do Action",
    Callback = function()
        print("Action executed!")
        CircularNotification("KaLi Hub", "Action executed!", "rbxassetid://6034818375", 3)
    end
})

MainTab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
        CircularNotification("KaLi Hub", "Feature toggled!", "rbxassetid://6034818375", 3)
    end
})

MainTab:AddSlider({
    Name = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 1,
    Color = Color3.fromRGB(0, 170, 255),
    Callback = function(value)
        print("Power Level:", value)
    end
})

MainTab:AddDropdown({
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "Torso", "Random"},
    Callback = function(option)
        print("Target part:", option)
    end
})

MainTab:AddBind({
    Name = "Action Key",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        print("Keybind pressed!")
    end
})

--// Settings Tab
SettingsTab:AddToggle({
    Name = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications:", state)
    end
})

SettingsTab:AddDropdown({
    Name = "Mode",
    Default = "Easy",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

SettingsTab:AddButton({
    Name = "Save Config",
    Callback = function()
        OrionLib:SaveConfig()
        print("Config saved!")
        CircularNotification("KaLi Hub", "Config saved!", "rbxassetid://6034818375", 3)
    end
})

SettingsTab:AddButton({
    Name = "Load Config",
    Callback = function()
        OrionLib:LoadConfig()
        print("Config loaded!")
        CircularNotification("KaLi Hub", "Config loaded!", "rbxassetid://6034818375", 3)
    end
})

--// About Tab
AboutTab:AddLabel("Created by YourName")
AboutTab:AddLabel("Version 2.0")
AboutTab:AddLabel("Using Orion UI Library")

--// Initial Notification
CircularNotification("KaLi Hub", "GUI Loaded Successfully!", "rbxassetid://6034818375", 3)

--// Default Tab
MainTab:Select()
