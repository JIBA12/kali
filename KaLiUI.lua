--===========================--
-- KaLiUI - Custom UI Library
--===========================--

local KaLiUI = {}
KaLiUI.__index = KaLiUI

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Create a ScreenGui
KaLiUI.ScreenGui = Instance.new("ScreenGui")
KaLiUI.ScreenGui.Name = "KaLiHubGUI"
KaLiUI.ScreenGui.Parent = PlayerGui

-- Helper: smooth dragging
function KaLiUI:MakeDraggable(Frame)
    local dragging, dragInput, dragStart, startPos
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

--===========================--
-- Create Window
--===========================--
function KaLiUI:CreateWindow(title)
    local WindowFrame = Instance.new("Frame")
    WindowFrame.Size = UDim2.fromOffset(500, 450)
    WindowFrame.Position = UDim2.fromScale(0.3,0.3)
    WindowFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    WindowFrame.BorderSizePixel = 0
    WindowFrame.Parent = self.ScreenGui

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,30)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20
    Title.Parent = WindowFrame

    self:MakeDraggable(WindowFrame)

    local window = {}
    window.Frame = WindowFrame
    window.Tabs = {}

    function window:Tab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 0, 30)
        TabButton.Position = UDim2.new(0, 10 + (#window.Tabs * 110), 0, 35)
        TabButton.Text = name
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.TextSize = 16
        TabButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
        TabButton.TextColor3 = Color3.fromRGB(255,255,255)
        TabButton.Parent = WindowFrame

        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1,-20,1,-70)
        TabFrame.Position = UDim2.new(0,10,0,70)
        TabFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
        TabFrame.Visible = false
        TabFrame.Parent = WindowFrame

        local tab = {Frame = TabFrame, Sections = {}}
        table.insert(window.Tabs, tab)

        -- Show tab on button click
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(window.Tabs) do
                t.Frame.Visible = false
            end
            TabFrame.Visible = true
        end)

        function tab:Section(name)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1,-20,0,200)
            SectionFrame.Position = UDim2.new(0,10,0,#tab.Sections*210)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
            SectionFrame.Parent = TabFrame

            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Size = UDim2.new(1,0,0,25)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(255,255,255)
            SectionTitle.Font = Enum.Font.SourceSansBold
            SectionTitle.TextSize = 18
            SectionTitle.Parent = SectionFrame

            local section = {Frame = SectionFrame, YOffset = 30}

            function section:Button(text, callback)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1,-20,0,30)
                btn.Position = UDim2.new(0,10,0,section.YOffset)
                btn.Text = text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 16
                btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.Parent = SectionFrame
                section.YOffset = section.YOffset + 35

                btn.MouseButton1Click:Connect(callback)
            end

            function section:Toggle(text, default, callback)
                local toggleFrame = Instance.new("Frame")
                toggleFrame.Size = UDim2.new(1,-20,0,30)
                toggleFrame.Position = UDim2.new(0,10,0,section.YOffset)
                toggleFrame.BackgroundTransparency = 1
                toggleFrame.Parent = SectionFrame

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0.7,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = text
                label.TextColor3 = Color3.fromRGB(255,255,255)
                label.Font = Enum.Font.SourceSans
                label.TextSize = 16
                label.Parent = toggleFrame

                local state = default or false
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0.3,-5,1,0)
                btn.Position = UDim2.new(0.7,5,0,0)
                btn.Text = state and "ON" or "OFF"
                btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.Font = Enum.Font.SourceSansBold
                btn.TextSize = 14
                btn.Parent = toggleFrame

                btn.MouseButton1Click:Connect(function()
                    state = not state
                    btn.Text = state and "ON" or "OFF"
                    btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
                    callback(state)
                end)

                section.YOffset = section.YOffset + 35
            end

            table.insert(tab.Sections, section)
            return section
        end

        return tab
    end

    return window
end

return KaLiUI
