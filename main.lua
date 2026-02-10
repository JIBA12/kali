--// KaLi Hub - Shaman GUI with Smooth Dragging

-- Load Shaman Library safely
local Library
local success, lib = pcall(function()
    return loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua"
    ))()
end)

if success then
    Library = lib
else
    warn("Failed to load GUI library!")
    return
end

local Flags = Library.Flags

--// Window
local Window = Library:Window({
    Text = "KaLi Hub"
})

--// Smooth Dragging
do
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")

    local DragFrame = Window.Frame  -- Shaman main frame
    local dragging = false
    local dragInput, mousePos, framePos

    DragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = DragFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    DragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - mousePos
            local newPos = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )

            TweenService:Create(
                DragFrame,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = newPos}
            ):Play()
        end
    end)
end

--// Tabs
local MainTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })

--// Sections
local MainSection = MainTab:Section({ Text = "Features" })
local SettingsSection = SettingsTab:Section({ Text = "Options" })

--// Main Section Features
MainSection:Button({
    Text = "Do Action",
    Tooltip = "Executes main action",
    Callback = function()
        print("Main action executed!")
    end
})

MainSection:Toggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
})

MainSection:Slider({
    Text = "Power Level",
    Minimum = 0,
    Maximum = 100,
    Default = 50,
    Flag = "PowerLevel",
    Callback = function(value)
        print("Power Level:", value)
    end
})

MainSection:ColorPicker({
    Text = "Select Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Color chosen:", color)
    end
})

--// Settings Section
SettingsSection:Toggle({
    Text = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
})

SettingsSection:Dropdown({
    Text = "Mode",
    List = {"Easy", "Medium", "Hard"},
    Flag = "ModeSelect",
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

SettingsSection:Input({
    Text = "Set Name",
    Placeholder = "Enter name here",
    Flag = "PlayerName",
    Callback = function(text)
        print("Name set to:", text)
    end
})

--// Label Example
local infoLabel = SettingsSection:Label({
    Text = "Created by YourName",
    Color = Color3.fromRGB(150, 200, 255),
    Tooltip = "Credits"
})

--// Notification on GUI load
Library:Notify({
    Title = "KaLi Hub",
    Text = "GUI Loaded Successfully!",
    Duration = 5
})

--// Default tab selected
MainTab:Select()
