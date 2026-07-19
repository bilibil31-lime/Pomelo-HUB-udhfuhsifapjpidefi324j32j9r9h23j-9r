TAB1 name=Main into
[...
-- ==================================================
-- MAIN TAB : PLAYER PROFILE UI (BEAUTIFIED VERSION)
-- ==================================================
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local TabContainer = _G.CurrentPomeloTab
if not TabContainer then return end

-- ฟังก์ชันช่วยสร้างขอบเรืองแสงให้เข้ากับธีม Pomelo (ใช้เฉพาะในหน้านี้)
local function ApplyThemeStroke(parent, thickness, transparency)
    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = parent
    Stroke.Color = Color3.fromRGB(255, 255, 255)
    Stroke.Thickness = thickness or 1
    Stroke.Transparency = transparency or 0.2
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border 
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Parent = Stroke
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 180))
    })
    Gradient.Rotation = 45
    return Stroke
end

-- ==================================================
-- 1. การ์ดโปรไฟล์รวม (Profile Card)
-- ==================================================
local ProfileCard = Instance.new("Frame")
ProfileCard.Parent = TabContainer
ProfileCard.Size = UDim2.new(1, -20, 0, 120)
ProfileCard.Position = UDim2.new(0, 10, 0, 15)
ProfileCard.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
ProfileCard.BackgroundTransparency = 0.5 -- โปร่งแสงให้ดูหรู
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 10)
ApplyThemeStroke(ProfileCard, 1, 0.4) -- ขอบบางๆ ให้การ์ด

-- ==================================================
-- 2. รูปโปรไฟล์ผู้เล่น (Avatar)
-- ==================================================
local AvatarFrame = Instance.new("Frame")
AvatarFrame.Parent = ProfileCard
AvatarFrame.Size = UDim2.new(0, 90, 0, 90)
AvatarFrame.Position = UDim2.new(0, 15, 0.5, 0)
AvatarFrame.AnchorPoint = Vector2.new(0, 0.5)
AvatarFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", AvatarFrame).CornerRadius = UDim.new(1, 0)

-- ขอบรูปโปรไฟล์แบบไล่สี
ApplyThemeStroke(AvatarFrame, 2, 0)

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = AvatarFrame
AvatarImage.Size = UDim2.new(1, 0, 1, 0)
AvatarImage.BackgroundTransparency = 1
Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(1, 0)

-- ใช้ task.spawn เพื่อไม่ให้ UI กระตุกตอนดึงรูป
task.spawn(function()
    local content, isReady = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    if isReady then AvatarImage.Image = content end
end)

-- ==================================================
-- 3. ข้อมูลชื่อ (Name & Username)
-- ==================================================
local NameFrame = Instance.new("Frame")
NameFrame.Parent = ProfileCard
NameFrame.Size = UDim2.new(0.4, 0, 0, 60)
NameFrame.Position = UDim2.new(0, 120, 0.5, -5)
NameFrame.AnchorPoint = Vector2.new(0, 0.5)
NameFrame.BackgroundTransparency = 1

local NicknameLabel = Instance.new("TextLabel")
NicknameLabel.Parent = NameFrame
NicknameLabel.Size = UDim2.new(1, 0, 0, 30)
NicknameLabel.Position = UDim2.new(0, 0, 0, 0)
NicknameLabel.BackgroundTransparency = 1
NicknameLabel.Text = Player.DisplayName
NicknameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NicknameLabel.Font = Enum.Font.GothamBold
NicknameLabel.TextSize = 22
NicknameLabel.TextXAlignment = Enum.TextXAlignment.Left

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Parent = NameFrame
UsernameLabel.Size = UDim2.new(1, 0, 0, 20)
UsernameLabel.Position = UDim2.new(0, 0, 0, 30)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = "@" .. Player.Name
UsernameLabel.TextColor3 = Color3.fromRGB(255, 150, 220) -- สีชมพูอ่อนๆ ให้เข้าธีม
UsernameLabel.Font = Enum.Font.GothamMedium
UsernameLabel.TextSize = 14
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ==================================================
-- 4. โซนสถิติ (Stats Badges) - เปลี่ยนจากกล่องเทาเป็นป้ายเรียงกัน
-- ==================================================
local StatsContainer = Instance.new("Frame")
StatsContainer.Parent = ProfileCard
StatsContainer.Size = UDim2.new(0, 180, 1, -20)
StatsContainer.Position = UDim2.new(1, -10, 0.5, 0)
StatsContainer.AnchorPoint = Vector2.new(1, 0.5)
StatsContainer.BackgroundTransparency = 1

local StatLayout = Instance.new("UIListLayout")
StatLayout.Parent = StatsContainer
StatLayout.FillDirection = Enum.FillDirection.Vertical
StatLayout.SortOrder = Enum.SortOrder.LayoutOrder
StatLayout.Padding = UDim.new(0, 6)
StatLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- ฟังก์ชันสร้างป้าย Stat
local function CreateStatBadge(icon, text)
    local Badge = Instance.new("Frame")
    Badge.Parent = StatsContainer
    Badge.Size = UDim2.new(1, 0, 0, 26)
    Badge.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Badge.BackgroundTransparency = 0.4
    Instance.new("UICorner", Badge).CornerRadius = UDim.new(0, 6)
    
    local BadgeStroke = Instance.new("UIStroke")
    BadgeStroke.Parent = Badge
    BadgeStroke.Color = Color3.fromRGB(255, 255, 255)
    BadgeStroke.Transparency = 0.85
    BadgeStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local Lbl = Instance.new("TextLabel")
    Lbl.Parent = Badge
    Lbl.Size = UDim2.new(1, -15, 1, 0)
    Lbl.Position = UDim2.new(0, 10, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = icon .. "  " .. text
    Lbl.TextColor3 = Color3.fromRGB(220, 220, 230)
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.RichText = true -- เปิดใช้ RichText เพื่อเน้นตัวหนาเฉพาะจุด
end

-- สร้างป้าย 3 อัน
CreateStatBadge("⏳", "Age: <b>" .. tostring(Player.AccountAge) .. "</b> Days")
CreateStatBadge("⭐", "Status: <b>Unlimited (Dev)</b>")
CreateStatBadge("💎", "Credits: <b>9,999</b>")

-- ==================================================
-- 5. ส่วนแสดงเครดิตสคริปต์ (Footer & Divider)
-- ==================================================
local FooterContainer = Instance.new("Frame")
FooterContainer.Parent = TabContainer
FooterContainer.Size = UDim2.new(1, -20, 1, -150)
FooterContainer.Position = UDim2.new(0, 10, 0, 145)
FooterContainer.BackgroundTransparency = 1

-- เส้นคั่นไล่สี
local Divider = Instance.new("Frame")
Divider.Parent = FooterContainer
Divider.Size = UDim2.new(1, -60, 0, 1)
Divider.Position = UDim2.new(0.5, 0, 0, 0)
Divider.AnchorPoint = Vector2.new(0.5, 0)
Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Divider.BorderSizePixel = 0

local DivGradient = Instance.new("UIGradient")
DivGradient.Parent = Divider
DivGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 42)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 42))
})

-- ข้อความเครดิตจัดกลาง
local BottomText = Instance.new("TextLabel")
BottomText.Parent = FooterContainer
BottomText.Size = UDim2.new(1, 0, 1, -15)
BottomText.Position = UDim2.new(0, 0, 0, 10)
BottomText.BackgroundTransparency = 1
BottomText.Text = "<font color='rgb(255,180,220)'><b>POMELO HUB</b></font>\n\nScript Info & Credits\nCreated by [Your Name]\nVersion 1.0.0"
BottomText.TextColor3 = Color3.fromRGB(130, 130, 140)
BottomText.Font = Enum.Font.Gotham
BottomText.TextSize = 13
BottomText.TextYAlignment = Enum.TextYAlignment.Center
BottomText.RichText = true
]...
TAB2 name=Main2
[...
my 
]...
