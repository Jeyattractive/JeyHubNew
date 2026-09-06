local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP         = Players.LocalPlayer
local GUI_PARENT = LP:WaitForChild("PlayerGui", 9e9)
for _, c in ipairs(GUI_PARENT:GetChildren()) do
	if c.Name == "PABZINVIS_GUI" then pcall(function() c:Destroy() end) end
end
local isInvisibleActive = false
local invisibleConn     = nil
local invisibleParts    = {}
local function toggleInvisible(enable)
	isInvisibleActive = (enable ~= nil) and enable or not isInvisibleActive
	local char = LP and LP.Character
	local hum  = char and char:FindFirstChildOfClass("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")
	invisibleParts = {}
	if char then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Transparency < 1 then
				table.insert(invisibleParts, v)
			end
		end
	end
	if invisibleConn then invisibleConn:Disconnect(); invisibleConn = nil end
	if isInvisibleActive then
		for _, v in pairs(invisibleParts) do v.Transparency = 0.5 end
		invisibleConn = RunService.Heartbeat:Connect(function()
			if isInvisibleActive and char and root and hum then
				local ocf    = root.CFrame
				local oof    = hum.CameraOffset
				local hideCF = ocf * CFrame.new(0, -25, 0)
				root.CFrame      = hideCF
				hum.CameraOffset = hideCF:ToObjectSpace(CFrame.new(ocf.Position)).Position
				RunService.RenderStepped:Wait()
				root.CFrame      = ocf
				hum.CameraOffset = oof
			end
		end)
	else
		for _, v in pairs(invisibleParts) do v.Transparency = 0 end
		if hum then hum.CameraOffset = Vector3.new(0, 0, 0) end
	end
	return isInvisibleActive
end
local Gui = Instance.new("ScreenGui")
Gui.Name           = "PABZINVIS_GUI"
Gui.ResetOnSpawn   = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent         = GUI_PARENT
local minimized = false
local Main = Instance.new("Frame")
Main.Name             = "Main"
Main.Size             = UDim2.new(0, 180, 0, 88)
Main.Position         = UDim2.new(0.5, -90, 0.5, -44)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel  = 0
Main.ZIndex           = 10
Main.Parent           = Gui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local DragArea = Instance.new("Frame")
DragArea.Size                   = UDim2.new(1, -54, 0, 28)
DragArea.Position               = UDim2.new(0, 0, 0, 0)
DragArea.BackgroundTransparency = 1
DragArea.ZIndex                 = 11
DragArea.Parent                 = Main
local Title = Instance.new("TextLabel")
Title.Size                   = UDim2.new(1, -10, 1, 0)
Title.Position               = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text                   = "PABZINVIS"
Title.TextColor3             = Color3.fromRGB(210, 210, 210)
Title.TextSize               = 11
Title.Font                   = Enum.Font.GothamBold
Title.TextXAlignment         = Enum.TextXAlignment.Left
Title.ZIndex                 = 12
Title.Parent                 = DragArea
local MinBtn = Instance.new("TextButton")
MinBtn.Size             = UDim2.new(0, 22, 0, 20)
MinBtn.Position         = UDim2.new(1, -50, 0, 4)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.Text             = "-"
MinBtn.TextColor3       = Color3.fromRGB(180, 180, 180)
MinBtn.TextSize         = 13
MinBtn.Font             = Enum.Font.GothamBold
MinBtn.BorderSizePixel  = 0
MinBtn.ZIndex           = 20
MinBtn.Parent           = Main
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 4)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size             = UDim2.new(0, 22, 0, 20)
CloseBtn.Position         = UDim2.new(1, -24, 0, 4)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseBtn.Text             = "X"
CloseBtn.TextColor3       = Color3.fromRGB(180, 180, 180)
CloseBtn.TextSize         = 11
CloseBtn.Font             = Enum.Font.GothamBold
CloseBtn.BorderSizePixel  = 0
CloseBtn.ZIndex           = 20
CloseBtn.Parent           = Main
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)
local Divider = Instance.new("Frame")
Divider.Size             = UDim2.new(1, -20, 0, 1)
Divider.Position         = UDim2.new(0, 10, 0, 30)
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Divider.BorderSizePixel  = 0
Divider.ZIndex           = 11
Divider.Parent           = Main
local Body = Instance.new("Frame")
Body.Size                   = UDim2.new(1, 0, 1, -32)
Body.Position               = UDim2.new(0, 0, 0, 32)
Body.BackgroundTransparency = 1
Body.ZIndex                 = 11
Body.Parent                 = Main
local TogBtn = Instance.new("TextButton")
TogBtn.Size             = UDim2.new(1, -20, 0, 30)
TogBtn.Position         = UDim2.new(0, 10, 0, 10)
TogBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TogBtn.Text             = "INVISIBLE  OFF"
TogBtn.TextColor3       = Color3.fromRGB(160, 160, 160)
TogBtn.TextSize         = 11
TogBtn.Font             = Enum.Font.GothamBold
TogBtn.BorderSizePixel  = 0
TogBtn.ZIndex           = 12
TogBtn.Parent           = Body
Instance.new("UICorner", TogBtn).CornerRadius = UDim.new(0, 6)
TogBtn.MouseButton1Click:Connect(function()
	local result = toggleInvisible()
	if result then
		TogBtn.Text             = "INVISIBLE  ON"
		TogBtn.TextColor3       = Color3.fromRGB(220, 220, 220)
		TogBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	else
		TogBtn.Text             = "INVISIBLE  OFF"
		TogBtn.TextColor3       = Color3.fromRGB(160, 160, 160)
		TogBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	end
end)
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		Body.Visible    = false
		Divider.Visible = false
		Main.Size       = UDim2.new(0, 180, 0, 30)
		MinBtn.Text     = "+"
	else
		Body.Visible    = true
		Divider.Visible = true
		Main.Size       = UDim2.new(0, 180, 0, 88)
		MinBtn.Text     = "-"
	end
end)
CloseBtn.MouseButton1Click:Connect(function()
	if isInvisibleActive then toggleInvisible(false) end
	Gui:Destroy()
end)
local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
DragArea.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging  = true
		dragStart = input.Position
		startPos  = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
DragArea.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta   = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
