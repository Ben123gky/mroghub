-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "MROG HUB",
    LoadingTitle = "MROG HUB",
    LoadingSubtitle = "by mrog",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Big Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})

-- Create Tabs
local Tab = Window:CreateTab("Player", 4483362458) -- Title, Image

-- Color Picker
local ColorPicker = Tab:CreateColorPicker({
    Name = "Color Picker",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "ColorPicker1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        -- The function that takes place every time the color picker is moved/changed
        -- The variable (Value) is a Color3.fromRGB value based on which color is selected
        print("Color selected: ", Value)
    end
})

-- Notification
Rayfield:Notify({
    Title = "Read = HANDSOME",
    Content = "This script made by mr0g | AND U HANDSOME😋🤑",
    Duration = 6.5,
    Image = 4483362458,
    Actions = { -- Notification Buttons
        Ignore = {
            Name = "Okay!",
            Callback = function()
                print("The user tapped Okay!")
            end
        }
    }
})

-- Keybind
local Keybind = Tab:CreateKeybind({
    Name = "Keybind Example",
    CurrentKeybind = "K",
    HoldToInteract = false,
    Flag = "Keybind1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Keybind)
        -- The function that takes place when the keybind is pressed
        -- The variable (Keybind) is a boolean for whether the keybind is being held or not (HoldToInteract needs to be true)
        print("Keybind pressed: ", Keybind)
    end
})

-- Sirius Library Script

-- Dependencies
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Aim
local Aim = {}

function Aim.Aimbot()
    local function getClosestPlayer()
        local closestPlayer = nil
        local shortestDistance = math.huge

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                local distance = (Vector2.new(pos.X, pos.Y) - Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)).magnitude
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
        return closestPlayer
    end

    RunService.RenderStepped:Connect(function()
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end)
end

function Aim.Triggerbot()
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local target = getClosestPlayer()
            if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.Health = 0
            end
        end
    end)
end

-- ESP
local ESP = {}

function ESP.Wallhack()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
        end
    end
end

function ESP.PlayerESP()
    RunService.RenderStepped:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local billboard = Instance.new("BillboardGui", player.Character.HumanoidRootPart)
                billboard.Size = UDim2.new(1, 0, 1, 0)
                billboard.Adornee = player.Character.HumanoidRootPart

                local textLabel = Instance.new("TextLabel", billboard)
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = player.Name
                textLabel.TextColor3 = Color3.new(1, 0, 0)
                textLabel.BackgroundTransparency = 1
            end
        end
    end)
end

-- Blatant
local Blatant = {}

function Blatant.Speedhack()
    local speed = 100
    RunService.RenderStepped:Connect(function()
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end)
end

function Blatant.Flyhack()
    local flying = false
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.F then
            flying = not flying
            if flying then
                LocalPlayer.Character.HumanoidRootPart.Anchored = true
            else
                LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end
    end)

    RunService.RenderStepped:Connect(function()
        if flying then
            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
        end
    end)
end

-- Mics
local Mics = {}

function Mics.Noclip()
    RunService.Stepped:Connect(function()
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

function Mics.InfiniteJump()
    UserInputService.JumpRequest:Connect(function()
        LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end)
end

-- Initialize Library
local Library = {
    Aim = Aim,
    ESP = ESP,
    Blatant = Blatant,
    Mics = Mics
}

-- Integrate Library Functions with Rayfield UI
local AimbotToggle = Tab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        if Value then
            Aim.Aimbot()
        else
            -- Stop Aimbot
        end
    end
})

local WallhackToggle = Tab:CreateToggle({
    Name = "Wallhack",
    CurrentValue = false,
    Flag = "WallhackToggle",
    Callback = function(Value)
        if Value then
            ESP.Wallhack()
        else
            -- Stop Wallhack
        end
    end
})

local SpeedhackToggle = Tab:CreateToggle({
    Name = "Speedhack",
    CurrentValue = false,
    Flag = "SpeedhackToggle",
    Callback = function(Value)
        if Value then
            Blatant.Speedhack()
        else
            -- Stop Speedhack
        end
    end
})

local FlyhackToggle = Tab:CreateToggle({
    Name = "Flyhack",
    CurrentValue = false,
    Flag = "FlyhackToggle",
    Callback = function(Value)
        if Value then
            Blatant.Flyhack()
        else
            -- Stop Flyhack
        end
    end
})

local NoclipToggle = Tab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
   
