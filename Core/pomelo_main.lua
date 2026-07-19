TAB1 name=Main
[...
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- ─── สร้างหน้าต่างเมนูทดสอบระบบ (Developer UI) ───
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DevAdminMenu"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 250)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- เปิดให้ลากย้ายตำแหน่งบนหน้าจอเพื่อทดสอบได้
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "DEV PANEL"
Title.TextColor3 = Color3.fromRGB(255, 105, 180)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- 1. ปุ่มรีตัวละคร (Reset Character Function)
local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.new(0.9, 0, 0, 35)
ResetBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ResetBtn.Text = "Reset Character"
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.Font = Enum.Font.SourceSansBold
ResetBtn.Parent = MainFrame
Instance.new("UICorner", ResetBtn).CornerRadius = UDim.new(0, 6)

ResetBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").Health = 0
    end
end)

-- 2. ช่องพิมพ์ชื่อและปุ่มวาป (Teleport Mechanic)
local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0.9, 0, 0, 35)
NameInput.Position = UDim2.new(0.05, 0, 0.4, 0)
NameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NameInput.Text = ""
NameInput.PlaceholderText = "พิมพ์ชื่อผู้เล่น..."
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.Parent = MainFrame
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)

local TpBtn = Instance.new("TextButton")
TpBtn.Size = UDim2.new(0.9, 0, 0, 35)
TpBtn.Position = UDim2.new(0.05, 0, 0.58, 0)
TpBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
TpBtn.Text = "Teleport to Player"
TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpBtn.Font = Enum.Font.SourceSansBold
TpBtn.Parent = MainFrame
Instance.new("UICorner", TpBtn).CornerRadius = UDim.new(0, 6)

TpBtn.MouseButton1Click:Connect(function()
    local targetName = NameInput.Text:lower()
    if targetName ~= "" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and (p.Name:lower():sub(1, #targetName) == targetName or p.DisplayName:lower():sub(1, #targetName) == targetName) then
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    -- ย้ายตำแหน่งพิกัด CFrame ไปยังจุดที่ผู้เล่นเป้าหมายอยู่
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    break
                end
            end
        end
    end
end)

-- 3. ปุ่มระบบบินสำหรับทดสอบแผนที่ (Flight Simulation)
local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(0.9, 0, 0, 35)
FlyBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
FlyBtn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
FlyBtn.Text = "Fly: OFF"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSansBold
FlyBtn.Parent = MainFrame
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 6)

local flying = false
local speed = 50
local bv, bg

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyBtn.Text = "Fly: ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
        
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.CFrame = root.CFrame
        bg.Parent = root
        
        task.spawn(function()
            while flying and root and root.Parent do
                local cam = workspace.CurrentCamera
                local dir = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                
                if dir.Magnitude > 0 then
                    bv.Velocity = dir.Unit * speed
                else
                    bv.Velocity = Vector3.new(0, 0.1, 0)
                end
                bg.CFrame = cam.CFrame
                task.wait()
            end
        end)
    else
        FlyBtn.Text = "Fly: OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(34, 139, 34)
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end)
]...
