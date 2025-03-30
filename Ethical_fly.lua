local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = game.Workspace.CurrentCamera

local flying = false
local flySpeed = 50
local bodyVelocity
local bodyGyro

local function startFlying()
    if flying then return end
    flying = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyGyro = Instance.new("BodyGyro")

    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")

    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.CFrame = character.HumanoidRootPart.CFrame
    bodyGyro.Parent = character:WaitForChild("HumanoidRootPart")

    humanoid.PlatformStand = true
end

local function stopFlying()
    if not flying then return end
    flying = false

    bodyVelocity:Destroy()
    bodyGyro:Destroy()

    humanoid.PlatformStand = false
end

startFlying()

game:GetService("RunService").Heartbeat:Connect(function()
    if flying then
        local velocity = Vector3.new()

        local cameraDirection = camera.CFrame.LookVector
        local cameraRight = camera.CFrame.RightVector
        local cameraUp = camera.CFrame.UpVector

        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            velocity = velocity + cameraDirection
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            velocity = velocity - cameraDirection
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            velocity = velocity - cameraRight
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            velocity = velocity + cameraRight
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + cameraUp
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
            velocity = velocity - cameraUp
        end

        bodyVelocity.Velocity = velocity * flySpeed
        bodyGyro.CFrame = CFrame.new(character.HumanoidRootPart.Position, character.HumanoidRootPart.Position + cameraDirection)
    end
end)
