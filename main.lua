-- ===============================
-- Tab Section (Left Area)
-- ===============================
local TAB_WIDTH = 100 -- width of the tab section

-- Tab Container
local TabSection = Instance.new("Frame")
TabSection.Size = UDim2.new(0, TAB_WIDTH, 1, -HEADER_HEIGHT) -- full height minus header
TabSection.Position = UDim2.new(0, 0, 0, HEADER_HEIGHT) -- below header
TabSection.BackgroundColor3 = Color3.fromRGB(25,25,30)
TabSection.BorderSizePixel = 0
TabSection.Parent = Main
Instance.new("UICorner", TabSection)

-- Vertical Divider Line
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0,1,1,0) -- 1px width, full height of Main minus header
Divider.Position = UDim2.new(0, TAB_WIDTH, 0, HEADER_HEIGHT)
Divider.BackgroundColor3 = Color3.fromRGB(80,160,255)
Divider.BorderSizePixel = 0
Divider.Parent = Main

-- Example: Add a tab button
local function createTab(name, positionY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,35)
    btn.Position = UDim2.new(0,0,0,positionY)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = TabSection
    Instance.new("UICorner", btn)
    return btn
end

-- Example tabs
createTab("Home", 10)
createTab("Settings", 55)
createTab("Scripts", 100)
