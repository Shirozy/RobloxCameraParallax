--===== CONFIGURATION =====--
local Config = {
    CameraPosition    = Vector3.new(20, 100, 0), -- The position of the camera
    LookAtPosition    = Vector3.new(0, 100, 0), -- The CFrame the camera will face
    FieldOfView       = 65, -- The FOV of the camera
    MaxSideOffset     = 5, -- Max Horizontal offset 
    MaxVerticalOffset = 5, -- Max Vertical Offset
}

--===== SETUP =====--
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
camera.CameraType   = Enum.CameraType.Scriptable
camera.FieldOfView  = Config.FieldOfView

local baseCFrame   = CFrame.new(Config.CameraPosition, Config.LookAtPosition)
local rightVector  = baseCFrame.RightVector
local upVector     = baseCFrame.UpVector

camera.CFrame = baseCFrame
local mouse      = player:GetMouse()

--===== RENDER LOOP =====--
RunService.RenderStepped:Connect(function()
    local vw, vh = camera.ViewportSize.X, camera.ViewportSize.Y

    local normX = (mouse.X / vw) - 0.5
    local normY = (mouse.Y / vh) - 0.5

    local offsetX = math.clamp(-normX * Config.MaxSideOffset,
                               -Config.MaxSideOffset, Config.MaxSideOffset)
    local offsetY = math.clamp( normY * Config.MaxVerticalOffset,
                               -Config.MaxVerticalOffset, Config.MaxVerticalOffset)

    local horizontalOffset = rightVector * offsetX
    local verticalOffset   = upVector    * offsetY

    local adjustedLookAt = Config.LookAtPosition
                           + horizontalOffset
                           + verticalOffset

    camera.CFrame = CFrame.new(Config.CameraPosition, adjustedLookAt)
end)
