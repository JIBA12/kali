-- KaLiHub Mobile Compact + Minimize + Close
pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    -- Wait for player
    local player
    repeat
        player = Players.LocalPlayer
        RunService.RenderStepped:Wait()
    until player

    local playerGui = player:WaitForChild("PlayerGui")

    -- Remove old GUI
    if CoreGui:FindFirstChild("KaLiHub") then
        CoreGui.KaLiHub:Destroy()
    end

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "KaLiHub"
    gui.ResetOnSpawn = false
    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then gui.Parent = playerGui end

    ------------------------------------------------------------------
    -- Main Window
    ------------------------------------------------------------------
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 320, 0, 260)
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    window.Position = UDim2.new(0.5, 0, 0.5, 0)
    window.BackgroundColor3 = Color3.fromRGB(25,25,30)
    window.BorderSizePixel = 0
    window.Active = true
    window.Parent = gui
    Instance.new("UICorner", window).CornerRadius = UDim.new(0,8)

    ------------------------------------------------------------------
    -- Top Bar
    ------------------------------------------------------------------
    local top = Instance.new("Frame")
    top.Size = UDim2.new(1,0,0,35)
    top.BackgroundColor3 = Color3.fromRGB(18,18,22)
    top.BorderSizePixel = 0
    top.Parent = window
    Instance.new("UICorner", top).CornerRadius = UDim.new(0,8)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,-70,1,0)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.Text = "KaLi Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.fromRGB(0,170,255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = top

    -- Minimize Button
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.new(0,30,0,30)
    minimize.Position = UDim2.new(1,-65,0,2)
    minimize.Text = "-"
    minimize.Font = Enum.Font.GothamBold
    minimize.TextSize = 16
    minimize.BackgroundColor3 = Color3.fromRGB(50,50,60)
    minimize.TextColor3 = Color3.new(1,1,1)
    minimize.Parent = top
    Instance.new("UICorner", minimize).CornerRadius = UDim.new(0,6)

    -- Close Button
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-32,0,2)
    close.Text = "X"
    close.Font = Enum.Font.GothamBold
    close.TextSize = 14
    close.BackgroundColor3 = Color3.fromRGB(170,60,60)
    close.TextColor3 = Color3.new(1,1,1)
    close.Parent = top
    Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)

    ------------------------------------------------------------------
    -- Floating Circle (for minimize)
    ------------------------------------------------------------------
    local float = Instance.new("TextButton")
    float.Size = UDim2.new(0,50,0,50)
    float.Position = UDim2.new(0,100,0,100)
    float.BackgroundColor3 = Color3.fromRGB(0,170,255)
    float.Text = "KaLi"
    float.Font = Enum.Font.GothamBold
    float.TextSize = 12
    float.TextColor3 = Color3.new(1,1,1)
    float.Visible = false
    float.Parent = gui
    Instance.new("UICorner", float).CornerRadius = UDim.new(1,0) -- circle

    ------------------------------------------------------------------
    -- Example Content
    ------------------------------------------------------------------
    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1,0,1,-35)
    content.Position = UDim2.new(0,0,0,35)
    content.BackgroundTransparency = 1
    content.Text = "KaLiHub Mobile UI"
    content.TextColor3 = Color3.new(1,1,1)
    content.Font = Enum.Font.Gotham
    content.TextSize = 14
    content.Parent = window

    ------------------------------------------------------------------
    -- Close / Minimize Logic
    ------------------------------------------------------------------
    close.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    minimize.MouseButton1Click:Connect(function()
        window.Visible = false
        float.Visible = true
    end)

    float.MouseButton1Click:Connect(function()
        window.Visible = true
        float.Visible = false
    end)

    ------------------------------------------------------------------
    -- Drag Function (Mobile + PC)
    ------------------------------------------------------------------
    local function makeDraggable(frame)
        local dragging = false
        local dragStart, startPos

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    makeDraggable(top)    -- drag window
    makeDraggable(float)  -- drag floating circle

end)
