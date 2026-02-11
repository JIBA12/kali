-- KaLiHub Universal (PC + Mobile Fixed)
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
    -- MAIN WINDOW
    ------------------------------------------------------------------
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 320, 0, 260)
    window.Position = UDim2.new(0.5, -160, 0.5, -130)
    window.BackgroundColor3 = Color3.fromRGB(25,25,30)
    window.BorderSizePixel = 0
    window.Active = true
    window.Parent = gui

    Instance.new("UICorner", window).CornerRadius = UDim.new(0,8)

    ------------------------------------------------------------------
    -- TOP BAR
    ------------------------------------------------------------------
    local top = Instance.new("Frame")
    top.Size = UDim2.new(1,0,0,35)
    top.BackgroundColor3 = Color3.fromRGB(18,18,22)
    top.BorderSizePixel = 0
    top.Parent = window

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

    -- Minimize
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.new(0,30,0,30)
    minimize.Position = UDim2.new(1,-65,0,2)
    minimize.Text = "-"
    minimize.BackgroundColor3 = Color3.fromRGB(60,60,70)
    minimize.TextColor3 = Color3.new(1,1,1)
    minimize.Parent = top
    Instance.new("UICorner", minimize).CornerRadius = UDim.new(0,6)

    -- Close
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-32,0,2)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(170,60,60)
    close.TextColor3 = Color3.new(1,1,1)
    close.Parent = top
    Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)

    ------------------------------------------------------------------
    -- FLOATING BUTTON (Circle)
    ------------------------------------------------------------------
    local float = Instance.new("TextButton")
    float.Size = UDim2.new(0,50,0,50)
    float.Position = UDim2.new(0,100,0,100)
    float.BackgroundColor3 = Color3.fromRGB(0,170,255)
    float.Text = "KaLi"
    float.TextColor3 = Color3.new(1,1,1)
    float.Visible = false
    float.Parent = gui
    Instance.new("UICorner", float).CornerRadius = UDim.new(1,0)

    ------------------------------------------------------------------
    -- CONTENT
    ------------------------------------------------------------------
    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1,0,1,-35)
    content.Position = UDim2.new(0,0,0,35)
    content.BackgroundTransparency = 1
    content.Text = "KaLiHub Ready"
    content.TextColor3 = Color3.new(1,1,1)
    content.Font = Enum.Font.Gotham
    content.TextSize = 14
    content.Parent = window

    ------------------------------------------------------------------
    -- CLOSE / MINIMIZE
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
    -- UNIVERSAL DRAG (PC + MOBILE) - FIXED
    ------------------------------------------------------------------
    local function makeDraggable(frame)
        local dragging = false
        local dragInput
        local startPos
        local startMousePos

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                startMousePos = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - startMousePos
                frame.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    -- Drag window using top bar
    makeDraggable(top)

    -- Drag floating circle
    makeDraggable(float)

end)
