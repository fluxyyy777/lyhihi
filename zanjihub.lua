-- [[ ZANJI HUB - AURORA HOLO-GLASS KEY SYSTEM ]] --

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local parentUI = nil
pcall(function() parentUI = CoreGui end)
if not parentUI then parentUI = LocalPlayer:WaitForChild("PlayerGui") end

-- Xóa UI cũ nếu đang tồn tại
if parentUI:FindFirstChild("ZanjiHub_GetKey_UI") then
    parentUI["ZanjiHub_GetKey_UI"]:Destroy()
end

-- Hàm giải mã Hex bảo mật
local function decode(hex)
    local str = ""
    for i = 1, #hex, 2 do
        str = str .. string.char(tonumber(string.sub(hex, i, i+1), 16))
    end
    return str
end

-- Dữ liệu bảo mật (Đã mã hóa Hex)
local enc_key = "4e657443686561742d54456e4c59642d73314e504a6f" -- Key: NetCheat-TEnLYd-s1NPJo
local enc_link = "68747470733a2f2f6c696e6b346d2e6e65742f386743493031" -- Link: https://link4m.net/8gCI01
local enc_script = "68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f6a72306e7a7a2f7a616e6a696875622f726566732f68656164732f6d61696e2f6c6f616465722e6c7561"

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZanjiHub_GetKey_UI"
ScreenGui.Parent = parentUI
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 99999

-- Thông báo Prism Toast Notification
local function showNotify(msgText)
    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(0, 330, 0, 42)
    Toast.Position = UDim2.new(0.5, -165, -0.1, 0)
    Toast.BackgroundColor3 = Color3.fromHex("#080D1A")
    Toast.Parent = ScreenGui
    
    local ToastCorner = Instance.new("UICorner", Toast)
    ToastCorner.CornerRadius = UDim.new(0, 10)
    
    local ToastStroke = Instance.new("UIStroke", Toast)
    ToastStroke.Color = Color3.fromHex("#00F2FE")
    ToastStroke.Thickness = 1.5
    
    local ToastGrad = Instance.new("UIGradient", ToastStroke)
    ToastGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromHex("#00F2FE")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#4FACFE"))
    }

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "💎 " .. msgText
    Label.TextColor3 = Color3.fromHex("#F8FAFC")
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 11
    Label.Parent = Toast

    TweenService:Create(Toast, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -165, 0.04, 0)
    }):Play()
    
    task.delay(3, function()
        local tweenOut = TweenService:Create(Toast, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -165, -0.1, 0)
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function() Toast:Destroy() end)
    end)
end

-- Main Window (Giao diện Aurora Cyan Glass)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromHex("#070A14")
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Zoom in Animation
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 16)

-- Viền Neon Gradient Phát Sáng
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 1.8
MainStroke.Color = Color3.fromHex("#00F2FE")

local MainStrokeGrad = Instance.new("UIGradient", MainStroke)
MainStrokeGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromHex("#00F2FE")),
    ColorSequenceKeypoint.new(0.5, Color3.fromHex("#10B981")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#3B82F6"))
}

-- Thanh Glow Đỉnh Menu
local TopGlow = Instance.new("Frame")
TopGlow.Size = UDim2.new(1, 0, 0, 3)
TopGlow.Position = UDim2.new(0, 0, 0, 0)
TopGlow.BackgroundColor3 = Color3.fromHex("#00F2FE")
TopGlow.BorderSizePixel = 0
TopGlow.Parent = MainFrame

local TopGlowGrad = Instance.new("UIGradient", TopGlow)
TopGlowGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromHex("#00F2FE")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#10B981"))
}

-- Header Section
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, -30, 0, 50)
Header.Position = UDim2.new(0, 15, 0, 12)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local StatusBadge = Instance.new("Frame")
StatusBadge.Size = UDim2.new(0, 95, 0, 20)
StatusBadge.Position = UDim2.new(0, 0, 0, 0)
StatusBadge.BackgroundColor3 = Color3.fromHex("#0B192C")
StatusBadge.Parent = Header

local BadgeCorner = Instance.new("UICorner", StatusBadge)
BadgeCorner.CornerRadius = UDim.new(0, 20)

local BadgeStroke = Instance.new("UIStroke", StatusBadge)
BadgeStroke.Color = Color3.fromHex("#00F2FE")
BadgeStroke.Thickness = 1

local Dot = Instance.new("Frame")
Dot.Size = UDim2.new(0, 6, 0, 6)
Dot.Position = UDim2.new(0, 8, 0.5, -3)
Dot.BackgroundColor3 = Color3.fromHex("#10B981")
Dot.Parent = StatusBadge

local DotCorner = Instance.new("UICorner", Dot)
DotCorner.CornerRadius = UDim.new(1, 0)

local BadgeText = Instance.new("TextLabel")
BadgeText.Size = UDim2.new(1, -20, 1, 0)
BadgeText.Position = UDim2.new(0, 18, 0, 0)
BadgeText.BackgroundTransparency = 1
BadgeText.Text = "ZANJI VERIFIED"
BadgeText.TextColor3 = Color3.fromHex("#38BDF8")
BadgeText.Font = Enum.Font.GothamBold
BadgeText.TextSize = 8
BadgeText.TextXAlignment = Enum.TextXAlignment.Left
BadgeText.Parent = StatusBadge

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 0, 24)
Title.Position = UDim2.new(0, 102, 0, -2)
Title.BackgroundTransparency = 1
Title.Text = "ZANJI HUB <font color=\"#00F2FE\">SYSTEM</font>"
Title.RichText = true
Title.TextColor3 = Color3.fromHex("#FFFFFF")
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 15)
Subtitle.Position = UDim2.new(0, 0, 0, 24)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Nhập mã kích hoạt để tải toàn bộ tính năng Zanji Hub"
Subtitle.TextColor3 = Color3.fromHex("#64748B")
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Nút Đóng UI
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -28, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromHex("#1E293B")
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromHex("#94A3B8")
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 8)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Ô Nhập Key Cyber Input
local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, -30, 0, 44)
InputContainer.Position = UDim2.new(0, 15, 0, 70)
InputContainer.BackgroundColor3 = Color3.fromHex("#0F172A")
InputContainer.Parent = MainFrame

local InputCorner = Instance.new("UICorner", InputContainer)
InputCorner.CornerRadius = UDim.new(0, 10)

local InputStroke = Instance.new("UIStroke", InputContainer)
InputStroke.Color = Color3.fromHex("#1E293B")
InputStroke.Thickness = 1.2

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.PlaceholderText = "Dán Key của bạn vào đây..."
KeyInput.PlaceholderColor3 = Color3.fromHex("#475569")
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromHex("#F8FAFC")
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextSize = 12
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.Parent = InputContainer

KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromHex("#00F2FE")}):Play()
end)
KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromHex("#1E293B")}):Play()
end)

-- Group Nút Bấm Action
local ButtonGroup = Instance.new("Frame")
ButtonGroup.Size = UDim2.new(1, -30, 0, 42)
ButtonGroup.Position = UDim2.new(0, 15, 0, 126)
ButtonGroup.BackgroundTransparency = 1
ButtonGroup.Parent = MainFrame

-- Nút Get Key (Cyan Gradient)
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromHex("#0284C7")
GetKeyBtn.Text = "🌐 LẤY KEY (LINK4M)"
GetKeyBtn.TextColor3 = Color3.fromHex("#FFFFFF")
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 11
GetKeyBtn.Parent = ButtonGroup

local GetKeyCorner = Instance.new("UICorner", GetKeyBtn)
GetKeyCorner.CornerRadius = UDim.new(0, 10)

local GetKeyGrad = Instance.new("UIGradient", GetKeyBtn)
GetKeyGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromHex("#0284C7")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#00F2FE"))
}

-- Nút Submit Key (Emerald Gradient)
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.48, 0, 1, 0)
SubmitBtn.Position = UDim2.new(0.52, 0, 0, 0)
SubmitBtn.BackgroundColor3 = Color3.fromHex("#059669")
SubmitBtn.Text = "🚀 KÍCH HOẠT SCRIPT"
SubmitBtn.TextColor3 = Color3.fromHex("#FFFFFF")
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 11
SubmitBtn.Parent = ButtonGroup

local SubmitCorner = Instance.new("UICorner", SubmitBtn)
SubmitCorner.CornerRadius = UDim.new(0, 10)

local SubmitGrad = Instance.new("UIGradient", SubmitBtn)
SubmitGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromHex("#059669")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#10B981"))
}

-- Footer Banner Note
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, -30, 0, 44)
Footer.Position = UDim2.new(0, 15, 0, 180)
Footer.BackgroundColor3 = Color3.fromHex("#0B132B")
Footer.Parent = MainFrame

local FooterCorner = Instance.new("UICorner", Footer)
FooterCorner.CornerRadius = UDim.new(0, 10)

local FooterText = Instance.new("TextLabel")
FooterText.Size = UDim2.new(1, -16, 1, 0)
FooterText.Position = UDim2.new(0, 8, 0, 0)
FooterText.BackgroundTransparency = 1
FooterText.Text = "✨ Cảm ơn bạn đã lựa chọn Zanji Hub! Vui lòng lấy key tại Link4m để tiếp tục."
FooterText.TextColor3 = Color3.fromHex("#94A3B8")
FooterText.Font = Enum.Font.GothamMedium
FooterText.TextSize = 10
FooterText.TextWrapped = true
FooterText.TextYAlignment = Enum.TextYAlignment.Center
FooterText.Parent = Footer

-- Pop-in Animation
TweenService:Create(MainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 240)
}):Play()

-- Logic Lấy Key
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(decode(enc_link))
    showNotify("Đã sao chép link! Dán lên trình duyệt để lấy key")
    GetKeyBtn.Text = "✓ ĐÃ SAO CHÉP"
    task.wait(2)
    GetKeyBtn.Text = "🌐 LẤY KEY (LINK4M)"
end)

-- Logic Xác Nhận Key
SubmitBtn.MouseButton1Click:Connect(function()
    local input = KeyInput.Text
    local correctKey = decode(enc_key)
    
    if input == correctKey then
        SubmitBtn.Text = "✓ KÍCH HOẠT MỞ!"
        SubmitGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromHex("#2563EB")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#3B82F6"))
        }
        
        task.wait(0.6)
        
        -- Animation Đóng UI
        local tweenClose = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tweenClose:Play()
        tweenClose.Completed:Connect(function()
            ScreenGui:Destroy()
            
            -- Khởi chạy loader.lua của Zanji Hub
            local scriptUrl = decode(enc_script)
            local success, runErr = pcall(function()
                loadstring(game:HttpGet(scriptUrl))()
            end)
            if not success then
                warn("[Zanji Hub] Lỗi khởi chạy script chính: " .. tostring(runErr))
            end
        end)
    else
        SubmitBtn.Text = "✕ SAI KEY!"
        SubmitGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromHex("#DC2626")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#EF4444"))
        }
        
        task.wait(1.5)
        SubmitBtn.Text = "🚀 KÍCH HOẠT SCRIPT"
        SubmitGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromHex("#059669")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#10B981"))
        }
    end
end)
