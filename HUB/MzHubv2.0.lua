local players = game:GetService("Players")
local workspaceService = game:GetService("Workspace")
local tweenService = game:GetService("TweenService")
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local windui = loadstring(game:HttpGet("https://raw.githubusercontent.com/nxvap/windui/refs/heads/main/1.6.54.lua"))()

local window = windui:CreateWindow({
  Title = "MONK X AUTH0R HUB ( LIFE HUB)",
  Author = "User · " .. localPlayer.DisplayName,
  Icon = "rbxassetid://102312604991559",
  Size = UDim2.fromOffset(540, 420),
  Transparent = true,
  Theme = "Dark",
  HideSearchBar = false,
  User = { Enabled = true },
  OpenButton = {
    Title = "MONK X AUTH0R",
    Icon = "rbxassetid://102312604991559",
    CornerRadius = UDim.new(0, 15),
    StrokeThickness = 2,
    Enabled = true,
    Draggable = true,
    Color = ColorSequence.new(Color3.fromHex("000000"), Color3.fromHex("FFFFFF")),
  },
})

local function f1(title, content, p1, p2)
  windui:Notify({
    Title = title,
    Content = content,
    Duration = p1 or 3,
    Icon = p2 or "rbxassetid://102312604991559",
  })
end

local infoTab = window:Tab({ Title = "Info", Icon = "info" })
local playerTab = window:Tab({ Title = "Player", Icon = "user" })
MainTab = window:Tab({ Title = "Main", Icon = "house" })
FlingTab = window:Tab({ Title = "Fling", Icon = "wind" })
ProtectionTab = window:Tab({ Title = "Protection", Icon = "shield" })
window:SelectTab(1)

infoTab:Section({ Title = "Info", Icon = "info", Opened = true })

infoTab:Image({
  Image = "https://raw.githubusercontent.com/MANASMCPE/AUTH0R/main/MONK_LOGO.png",
  AspectRatio = "16:9",
  Radius = 9,
})

infoTab:Space()

infoTab:Section({
  Title = "MONK X AUTH0R HUB [LIFE TOGETHER RP]",
  TextSize = 24,
  FontWeight = Enum.FontWeight.SemiBold,
})

infoTab:Space()

infoTab:Paragraph({
  Title = "MONK X AUTH0R Community",
  Desc = "Join the Discord official",
  Image = "rbxassetid://102312604991559",
  Thumbnail = "",
  ImageSize = 48,
  Buttons = {
    {
      Title = "Copy Discord link",
      Icon = "link",
      Callback = function() setclipboard("https://discord.gg/EVaFEpdrM") end,
    },
  },
})

infoTab:Space()

infoTab:Section({
  Title = [[
MONK X AUTH0R, Multilingual and multifuncional HUB, offering a variety options for you, in development state.
Developed by MONK]],
  TextSize = 18,
  TextTransparency = 0.35,
  FontWeight = Enum.FontWeight.Medium,
})

infoTab:Section({
  Title = [[
New Features 1.0.0 (First Update):
Added: MONK X AUTH0RHUB
Credits: MONK]],
  TextSize = 14,
  TextTransparency = 0.45,
  FontWeight = Enum.FontWeight.Medium,
})

playerTab:Section({ Title = "Player", Icon = "user" })

playerTab:Slider({
  Title = "Speed",
  Step = 1,
  Value = { Min = 1, Max = 500, Default = 16 },
  Callback = function(value)
    local localPlayer2 = players.LocalPlayer

    local humanoid = (localPlayer2.Character
      or localPlayer2.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")

    if humanoid then
      humanoid.WalkSpeed = value
    end
  end,
})

local function f2(value2)
  if value2 ~= "" then
    for key, value3 in pairs(players:GetPlayers()) do
      if value3.Name:lower():match(value2:lower())
        or value3.DisplayName:lower():match(value2:lower()) then
        return value3
      end
    end

    return nil
  end

  return nil
end

playerTab:Slider({
  Title = "JumpPower",
  Step = 1,
  Value = { Min = 1, Max = 500, Default = 50 },
  Callback = function(value4)
    local localPlayer3 = players.LocalPlayer

    local humanoid2 = (localPlayer3.Character
      or localPlayer3.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")

    if humanoid2 then
      humanoid2.JumpPower = value4
    end
  end,
})

playerTab:Slider({
  Title = "Gravity",
  Step = 1,
  Value = { Min = 1, Max = 500, Default = 196 },
  Callback = function(value5) Workspace.Gravity = value5 end,
})

local v1 = false

userInputService.JumpRequest:Connect(function()
  if v1 then
    local character = players.LocalPlayer.Character

    if character and character:FindFirstChild("Humanoid") then
      character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
  end
end)

playerTab:Toggle({
  Title = "Infinite Jump",
  Default = false,
  Callback = function(value6) v1 = value6 end,
})

local v2

local resetValuesButton = playerTab:Button({
  Title = "Reset Values",
  Icon = "chevron-right",
  Default = false,
  Callback = function()
    local localPlayer4 = players.LocalPlayer

    local humanoid3 = (localPlayer4.Character
      or localPlayer4.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")

    if humanoid3 then
      humanoid3.WalkSpeed = 16
      humanoid3.JumpPower = 50
    end

    Workspace.Gravity = 196.2
    v1 = false
    v2:Highlight()
  end,
})

local v3 = false

local function f3(character2)
  if not character2 then
    return
  end

  for index, value7 in ipairs(character2:GetDescendants()) do
    if value7:IsA("BasePart") then
      value7.CanCollide = not v3
      value7.Anchored = false
    end
  end
end

local function f4(humanoidRootPart)
  if humanoidRootPart.Position.Y < -400 then
    humanoidRootPart.CFrame = CFrame.new(0, 100, 0)
  end
end

v2 = resetValuesButton
local v4 = {}

playerTab:Toggle({
  Title = "Ultimate Noclip",
  Default = false,
  Callback = function(value8)
    v3 = value8

    if value8 then
      v4.Heartbeat = runService.Heartbeat:Connect(function()
        local character3 = localPlayer.Character

        if character3 then
          f3(character3)
          local humanoidRootPart2 = character3:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart2 then
            f4(humanoidRootPart2)
          end
        end
      end)

      f1("Ultimate Noclip", "Enabled")
    else
      for key2, value9 in pairs(v4) do
        local v5 = value9
        pcall(function() v5:Disconnect() end)
      end

      v4 = {}

      if localPlayer.Character then
        f3(localPlayer.Character)
      end

      f1("Ultimate Noclip", "Disabled")
    end
  end,
})

playerTab:Section({ Title = "Change Fov", Icon = "user" })

local fovPlayer = 70

playerTab:Input({
  Title = "Fov Player",
  Desc = "Change the fov",
  Callback = function(value10) fovPlayer = tonumber(value10) or 70 end,
})

playerTab:Button({
  Title = "Adjust Fov",
  Icon = "chevron-right",
  Default = false,
  Callback = function()
    local currentCamera = Workspace.CurrentCamera

    if currentCamera and typeof(fovPlayer) == "number" then
      currentCamera.FieldOfView = fovPlayer
    end
  end,
})

localPlayer:GetMouse()
local v6 = false
local v7 = false
local v8 = false
local v9 = false
local v10 = false
local v11 = false
local v12 = false
local v13 = false
local v14 = false
local f5

local function f6(localPlayer5)
  if f5(localPlayer5):FindFirstChild("HumanoidRootPart") then
    return f5(localPlayer5).HumanoidRootPart
  end
end

function f5(p3)
  if p3.Character then
    return p3.Character
  end
end

local function f7(p4)
  task.spawn(function()
    local velocity

    if p4 then
      velocity = nil

      while true do
        pcall(function()
          velocity = f6(localPlayer).Velocity

          f6(localPlayer).Velocity = Vector3.new(
            math.random(-1500, 1500), -250000, math.random(-1500, 1500)
          )

          runService.RenderStepped:wait()
          f6(localPlayer).Velocity = velocity
        end)

        runService.Heartbeat:wait()

        if not v13 then
          break
        end
      end
    end
  end)
end

local function f8()
  localPlayer.Character.Animate.Disabled = false

  for key3, value11 in pairs((localPlayer.Character.Humanoid:GetPlayingAnimationTracks())) do
    value11:Stop()
  end
end

FlingTab:Section({ Title = "Select Player" })
local v15 = {}

local function f9()
  v15 = {}

  for key4, value12 in pairs(players:GetPlayers()) do
    if value12 ~= localPlayer then
      table.insert(v15, value12.Name)
    end
  end

  if #v15 == 0 then
    table.insert(v15, "No player available")
  end

  return v15
end

f9()

local flingTab = FlingTab
local values = v15
local name

flingTab:Dropdown({
  Title = "Select Player",
  Values = values,
  Value = #v15 > 0 and v15[1] or "No player available",
  Callback = function(value13)
    if value13 == "No player available" then
      name = nil
      return
    else
      local v16 = f2(value13)

      if v16 then
        name = v16.Name

        windui:Notify({
          Title = "Player",
          Content = name,
          Icon = "user-check",
          Duration = 2,
        })
      else
        name = nil
      end

      return
    end
  end,
})

players.PlayerAdded:Connect(function(player)
  if player ~= localPlayer then
    task.wait(1)
  end
end)

players.PlayerRemoving:Connect(function(player2)
  if name == player2.Name then
    name = nil
    v13 = false
    v6 = false
    v14 = false
    v7 = false
    v8 = false
    v9 = false
    v10 = false
    v11 = false
    v12 = false
  end

  task.wait(0.1)
end)

task.spawn(function()
  while true do
    task.wait(60)
  end
end)

FlingTab:Section({ Title = "Preview" })

FlingTab:Toggle({
  Title = "View Target",
  Desc = "View through the player camera",
  Value = false,
  Callback = function(value14)
    if not name then
      return
    end

    v14 = value14

    if value14 then
      task.spawn(function()
        while true do
          pcall(function()
            workspaceService.CurrentCamera.CameraSubject = players[name].Character.Humanoid
          end)

          task.wait(0.5)

          if not v14 then
            break
          end
        end

        workspaceService.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
      end)
    else
      workspaceService.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
    end
  end,
})

FlingTab:Section({ Title = "Fling Actions" })

FlingTab:Toggle({
  Title = "Touch Fling",
  Desc = "Fling improved when tapping on players",
  Value = false,
  Callback = function(value15)
    v13 = value15

    if value15 then
      local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
      workspace.FallenPartsDestroyHeight = (0 / 0)
      f7(true)
      task.wait(1)
      workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
    else
      f7(false)
    end
  end,
})

FlingTab:Toggle({
  Title = "Fling Player (With Noclip)",
  Desc = "Fling with bypass noclip",
  Value = false,
  Callback = function(value16)
    if not name then
      return
    end

    v6 = value16
    local position, v17, connect

    if value16 then
      if not v13 then
        v13 = true
        local fallenPartsDestroyHeight2 = workspace.FallenPartsDestroyHeight
        workspace.FallenPartsDestroyHeight = (0 / 0)
        f7(true)
        task.wait(1)
        workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight2
      end

      position = f6(localPlayer).Position
      v17 = true

      connect = nil

      connect = runService.Heartbeat:Connect(function()
        if not v6 then
          connect:Disconnect()
          return
        end

        pcall(function()
          local v18 = f6(localPlayer)

          if v18 then
            for key5, value17 in pairs(localPlayer.Character:GetDescendants()) do
              if value17:IsA("Script") or value17:IsA("LocalScript") then
                if value17.Name:lower():find("anti") or value17.Name:lower():find("fling")
                  or value17.Name:lower():find("exploit") then
                  value17.Disabled = true
                end
              end

              if value17:IsA("BodyPosition") or value17:IsA("BodyGyro") then
                if value17.Name:lower():find("anti") then
                  value17:Destroy()
                end
              end
            end

            if v18.AssemblyLinearVelocity.Magnitude > 500 then
              v18.AssemblyLinearVelocity = v18.AssemblyLinearVelocity * 0.8
            end
          end
        end)
      end)

      task.spawn(function()
        while v6 do
          pcall(function()
            local v19 = players[name]
            local character4 = v19 and v19.Character
            local vector, v20

            if character4 then
              v20 = f6(v19)
              local v21 = f6(localPlayer)

              if v20 and v21 then
                pcall(function()
                  for key6, value18 in pairs(v19.Character:GetDescendants()) do
                    if value18:IsA("BasePart") then
                      value18.CanCollide = true

                      if value18:FindFirstChild("NoClip") then
                        value18.NoClip:Destroy()
                      end
                    end
                  end
                end)

                local v22 = v20.Position + v20.AssemblyLinearVelocity * 0.25

                if v17 then
                  vector = Vector3.new(0, 4, 0)
                else
                  vector = Vector3.new(0, -1.5, 0)
                end

                for i = 1, 3 do
                  v21.CFrame = CFrame.new(v22 + vector)

                  for key7, value19 in pairs(localPlayer.Character:GetDescendants()) do
                    local v23 = value19

                    if v23:IsA("BasePart") then
                      v23.CanCollide = true
                      v23.Massless = false

                      pcall(function()
                        v23.CustomPhysicalProperties = PhysicalProperties.new(
                          20, 0.1, 0.8, 100, 100
                        )
                      end)
                    end
                  end

                  task.wait(0.01)
                end

                local tempBodyVelocity = v21:FindFirstChild("TempBodyVelocity")

                if not tempBodyVelocity then
                  tempBodyVelocity = Instance.new("BodyVelocity")
                  tempBodyVelocity.Name = "TempBodyVelocity"
                  tempBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                  tempBodyVelocity.Parent = v21
                end

                local v24 = math.random(60, 100)

                if v17 then
                  tempBodyVelocity.Velocity = Vector3.new(
                    math.random(-10, 10), v24, math.random(-10, 10)
                  )
                else
                  tempBodyVelocity.Velocity = Vector3.new(
                    math.random(-10, 10), -v24, math.random(-10, 10)
                  )
                end

                pcall(function()
                  for key8, value20 in pairs(v20:GetChildren()) do
                    if value20:IsA("BodyForce") or value20:IsA("BodyVelocity")
                      or value20:IsA("BodyPosition") then
                      value20:Destroy()
                    end
                  end
                end)

                v17 = not v17
              end
            end
          end)

          task.wait(0.06)
        end

        pcall(function()
          local v25 = f6(localPlayer)

          if v25 then
            local tempBodyVelocity2 = v25:FindFirstChild("TempBodyVelocity")

            if tempBodyVelocity2 then
              tempBodyVelocity2:Destroy()
            end
          end

          for key9, value21 in pairs(localPlayer.Character:GetDescendants()) do
            if value21:IsA("BasePart") then
              value21.CustomPhysicalProperties = nil
            end
          end

          v25.CFrame = CFrame.new(position)
        end)
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "Fling Player (Bypass Anti Fling)",
  Desc = "Fling players with protection",
  Value = false,
  Callback = function(value22)
    if not name then
      return
    end

    v6 = value22
    local position2

    if value22 then
      if not v13 then
        v13 = true
        local fallenPartsDestroyHeight3 = workspace.FallenPartsDestroyHeight
        workspace.FallenPartsDestroyHeight = (0 / 0)
        f7(true)
        task.wait(1)
        workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight3
      end

      position2 = f6(localPlayer).Position

      task.spawn(function()
        while v6 do
          pcall(function()
            local v26 = players[name]
            local character5 = v26 and v26.Character
            local character6, v27

            if character5 then
              character6 = localPlayer.Character
              local humanoid4 = character6 and character6:FindFirstChildOfClass("Humanoid")
              v27 = f6(localPlayer)
              local character7 = v26.Character
              local humanoid5 = character7 and character7:FindFirstChildOfClass("Humanoid")
              local v28 = f6(v26)
              local head = character7 and character7:FindFirstChild("Head")

              if v27 and v28 and humanoid5 then
                if v27.Velocity.Magnitude < 50 then
                  getgenv().OldPos = v27.CFrame
                end

                if head then
                  workspace.CurrentCamera.CameraSubject = head
                elseif humanoid5 then
                  workspace.CurrentCamera.CameraSubject = humanoid5
                end

                local function f10(index2, cframe, cframe2)
                  v27.CFrame = CFrame.new(index2.Position) * cframe * cframe2
                  character6:SetPrimaryPartCFrame(CFrame.new(index2.Position) * cframe * cframe2)

                  v27.Velocity = Vector3.new(90000000, 900000000, 90000000)
                  v27.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
                end

                if not v27:FindFirstChild("ChaoticBV") then
                  local chaoticBV = Instance.new("BodyVelocity")
                  chaoticBV.Name = "ChaoticBV"
                  chaoticBV.Parent = v27
                  chaoticBV.Velocity = Vector3.new(900000000, 900000000, 900000000)
                  chaoticBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                end

                humanoid4:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                local v29 = v28

                if head and (v28.CFrame.p - head.CFrame.p).Magnitude > 5 then
                  v29 = head
                end

                local v30 = math.random(0, 360)

                if v29.Velocity.Magnitude < 50 then
                  local v31 = v30 + 100

                  f10(v29, CFrame.new(0, 1.5, 0)
                    + humanoid5.MoveDirection * v29.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v31), 0, 0))

                  task.wait()

                  f10(v29, CFrame.new(0, -1.5, 0)
                    + humanoid5.MoveDirection * v29.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v31), 0, 0))

                  task.wait()

                  f10(v29, CFrame.new(2.25, 1.5, -2.25)
                    + humanoid5.MoveDirection * v29.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v31), 0, 0))

                  task.wait()

                  f10(v29, CFrame.new(-2.25, -1.5, 2.25)
                    + humanoid5.MoveDirection * v29.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v31), 0, 0))

                  task.wait()

                  f10(
                    v29, CFrame.new(0, 1.5, 0) + humanoid5.MoveDirection,
                    CFrame.Angles(math.rad(v31), 0, 0)
                  )

                  task.wait()

                  f10(
                    v29, CFrame.new(0, -1.5, 0) + humanoid5.MoveDirection,
                    CFrame.Angles(math.rad(v31), 0, 0)
                  )
                else
                  f10(
                    v29, CFrame.new(0, 1.5, humanoid5.WalkSpeed),
                    CFrame.Angles(math.rad(90), 0, 0)
                  )

                  task.wait()
                  f10(v29, CFrame.new(0, -1.5, -humanoid5.WalkSpeed), CFrame.Angles(0, 0, 0))
                  task.wait()

                  f10(
                    v29, CFrame.new(0, 1.5, humanoid5.WalkSpeed),
                    CFrame.Angles(math.rad(90), 0, 0)
                  )

                  task.wait()

                  f10(
                    v29, CFrame.new(0, 1.5, v28.Velocity.Magnitude / 1.25),
                    CFrame.Angles(math.rad(90), 0, 0)
                  )

                  task.wait()

                  f10(
                    v29, CFrame.new(0, -1.5, -v28.Velocity.Magnitude / 1.25),
                    CFrame.Angles(0, 0, 0)
                  )

                  task.wait()

                  f10(
                    v29, CFrame.new(0, 1.5, v28.Velocity.Magnitude / 1.25),
                    CFrame.Angles(math.rad(90), 0, 0)
                  )

                  task.wait()
                  f10(v29, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                  task.wait()
                  f10(v29, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                  task.wait()
                  f10(v29, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                  task.wait()
                  f10(v29, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                end

                for key10, value23 in pairs(localPlayer.Character:GetDescendants()) do
                  local v32 = value23

                  if v32:IsA("BasePart") then
                    v32.CanCollide = true
                    v32.Massless = false

                    pcall(function()
                      v32.CustomPhysicalProperties = PhysicalProperties.new(
                        25, 0.1, 0.9, 100, 100
                      )
                    end)
                  end
                end

                for key11, value24 in pairs(character7:GetDescendants()) do
                  if value24:IsA("BasePart") then
                    value24.CanCollide = true
                  end
                end
              end
            end
          end)

          task.wait()
        end

        pcall(function()
          local v33 = f6(localPlayer)

          if v33 then
            local chaoticBV2 = v33:FindFirstChild("ChaoticBV")

            if chaoticBV2 then
              chaoticBV2:Destroy()
            end

            v33.CFrame = CFrame.new(position2)
            v33.Velocity = Vector3.new(0, 0, 0)
            v33.RotVelocity = Vector3.new(0, 0, 0)
          end

          local humanoid6 = localPlayer.Character
            and localPlayer.Character:FindFirstChildOfClass("Humanoid")

          if humanoid6 then
            humanoid6:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = humanoid6
          end

          for key12, value25 in pairs(localPlayer.Character:GetDescendants()) do
            if value25:IsA("BasePart") then
              value25.CustomPhysicalProperties = nil
            end
          end
        end)
      end)
    end
  end,
})

FlingTab:Section({ Title = "Special Actions" })

FlingTab:Toggle({
  Title = "Bang Player",
  Desc = "Bang on selected player",
  Value = false,
  Callback = function(value26)
    if not name then
      return
    end

    v7 = value26

    if value26 then
      task.spawn(function()
        while true do
          pcall(function()
            if players[name] and players[name].Character then
              local v34 = f6(players[name])

              f6(localPlayer).CFrame = v34.CFrame * CFrame.new(0, 0, 1.1)
              f6(localPlayer).Velocity = Vector3.new(0, 0, 0)
              f6(localPlayer).RotVelocity = Vector3.new(0, 0, 0)
            end
          end)

          task.wait()

          if not v7 then
            break
          end
        end

        f8()
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "Headsit Player",
  Desc = "Sit on the Player head",
  Value = false,
  Callback = function(value27)
    if not name then
      return
    end

    v8 = value27

    if value27 then
      task.spawn(function()
        while true do
          pcall(function()
            if players[name] and players[name].Character then
              local head2 = players[name].Character.Head
              localPlayer.Character.Humanoid.Sit = true

              f6(localPlayer).CFrame = head2.CFrame * CFrame.new(0, 2, 0)
              f6(localPlayer).Velocity = Vector3.new(0, 0, 0)
              f6(localPlayer).RotVelocity = Vector3.new(0, 0, 0)
            end
          end)

          task.wait()

          if not v8 then
            break
          end
        end
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "Stand Player",
  Desc = "Stand next to the Player",
  Value = false,
  Callback = function(value28)
    if not name then
      return
    end

    v9 = value28

    if value28 then
      task.spawn(function()
        while true do
          pcall(function()
            if players[name] and players[name].Character then
              local v35 = f6(players[name])

              f6(localPlayer).CFrame = v35.CFrame * CFrame.new(-3, 1, 0)
              f6(localPlayer).Velocity = Vector3.new(0, 0, 0)
              f6(localPlayer).RotVelocity = Vector3.new(0, 0, 0)
            end
          end)

          task.wait()

          if not v9 then
            break
          end
        end

        f8()
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "Backpack Player",
  Desc = "Staying on the Player back",
  Value = false,
  Callback = function(value29)
    if not name then
      return
    end

    v10 = value29

    if value29 then
      task.spawn(function()
        while true do
          pcall(function()
            if players[name] and players[name].Character then
              local v36 = f6(players[name])
              localPlayer.Character.Humanoid.Sit = true

              f6(localPlayer).CFrame = v36.CFrame * CFrame.new(0, 0, 1.2)
                * CFrame.Angles(0, -3, 0)

              f6(localPlayer).Velocity = Vector3.new(0, 0, 0)
              f6(localPlayer).RotVelocity = Vector3.new(0, 0, 0)
            end
          end)

          task.wait()

          if not v10 then
            break
          end
        end
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "Doggy Player",
  Desc = "Doggy mode",
  Value = false,
  Callback = function(value30)
    if not name then
      return
    end

    v11 = value30

    if value30 then
      task.spawn(function()
        while true do
          pcall(function()
            if players[name] and players[name].Character then
              f6(localPlayer).CFrame = players[name].Character.LowerTorso.CFrame
                * CFrame.new(0, 0.23, 0)

              f6(localPlayer).Velocity = Vector3.new(0, 0, 0)
              f6(localPlayer).RotVelocity = Vector3.new(0, 0, 0)
            end
          end)

          task.wait()

          if not v11 then
            break
          end
        end

        f8()
      end)
    end
  end,
})

FlingTab:Toggle({
  Title = "Drag Player",
  Desc = "Drag the player",
  Value = false,
  Callback = function(value31)
    if not name then
      return
    end

    v12 = value31

    if value31 then
      task.spawn(function()
        while true do
          pcall(function()
            if players[name] and players[name].Character then
              f6(localPlayer).CFrame = players[name].Character.RightHand.CFrame
                * CFrame.new(0, -2.5, 1) * CFrame.Angles(-2, -3, 0)

              f6(localPlayer).Velocity = Vector3.new(0, 0, 0)
              f6(localPlayer).RotVelocity = Vector3.new(0, 0, 0)
            end
          end)

          task.wait()

          if not v12 then
            break
          end
        end

        f8()
      end)
    end
  end,
})

FlingTab:Section({ Title = "Fling All" })

FlingTab:Toggle({
  Title = "Fling All",
  Desc = "Fling All Players",
  Value = false,
  Callback = function(value32)
    FlingAllActive = value32
    local position3

    if value32 then
      if not v13 then
        v13 = true
        local fallenPartsDestroyHeight4 = workspace.FallenPartsDestroyHeight
        workspace.FallenPartsDestroyHeight = (0 / 0)
        f7(true)
        task.wait(1)
        workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight4
      end

      position3 = f6(localPlayer).Position

      task.spawn(function()
        while FlingAllActive do
          pcall(function()
            for key13, value33 in pairs(players:GetPlayers()) do
              local v37 = value33

              if v37 ~= localPlayer and v37.Character then
                pcall(function()
                  local character8 = localPlayer.Character
                  local humanoid7 = character8 and character8:FindFirstChildOfClass("Humanoid")
                  local v38 = f6(localPlayer)
                  local character9 = v37.Character
                  local humanoid8 = character9 and character9:FindFirstChildOfClass("Humanoid")
                  local v39 = f6(v37)
                  local head3 = character9 and character9:FindFirstChild("Head")

                  if v38 and v39 and humanoid8 then
                    if v38.Velocity.Magnitude < 50 then
                      getgenv().OldPos = v38.CFrame
                    end

                    local function f11(index3, cframe3, cframe4)
                      v38.CFrame = CFrame.new(index3.Position) * cframe3 * cframe4

                      character8:SetPrimaryPartCFrame(CFrame.new(index3.Position) * cframe3
                        * cframe4)

                      v38.Velocity = Vector3.new(90000000, 900000000, 90000000)
                      v38.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
                    end

                    if not v38:FindFirstChild("ChaoticBV") then
                      local chaoticBV3 = Instance.new("BodyVelocity")
                      chaoticBV3.Name = "ChaoticBV"
                      chaoticBV3.Parent = v38
                      chaoticBV3.Velocity = Vector3.new(900000000, 900000000, 900000000)
                      chaoticBV3.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    end

                    humanoid7:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    local v40 = v39

                    if head3 and (v39.CFrame.p - head3.CFrame.p).Magnitude > 5 then
                      v40 = head3
                    end

                    local v41 = math.random(0, 360)

                    if v40.Velocity.Magnitude < 50 then
                      local v42 = v41 + 100

                      f11(v40, CFrame.new(0, 1.5, 0)
                        + humanoid8.MoveDirection * v40.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v42), 0, 0))

                      task.wait(0.05)

                      f11(v40, CFrame.new(0, -1.5, 0)
                        + humanoid8.MoveDirection * v40.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v42), 0, 0))

                      task.wait(0.05)

                      f11(v40, CFrame.new(2.25, 1.5, -2.25)
                        + humanoid8.MoveDirection * v40.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v42), 0, 0))

                      task.wait(0.05)

                      f11(v40, CFrame.new(-2.25, -1.5, 2.25)
                        + humanoid8.MoveDirection * v40.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(v42), 0, 0))
                    else
                      f11(
                        v40, CFrame.new(0, 1.5, humanoid8.WalkSpeed),
                        CFrame.Angles(math.rad(90), 0, 0)
                      )

                      task.wait(0.05)

                      f11(
                        v40, CFrame.new(0, -1.5, -humanoid8.WalkSpeed), CFrame.Angles(0, 0, 0)
                      )

                      task.wait(0.05)

                      f11(
                        v40, CFrame.new(0, 1.5, v39.Velocity.Magnitude / 1.25),
                        CFrame.Angles(math.rad(90), 0, 0)
                      )
                    end

                    for key14, value34 in pairs(localPlayer.Character:GetDescendants()) do
                      local v43 = value34

                      if v43:IsA("BasePart") then
                        v43.CanCollide = true
                        v43.Massless = false

                        pcall(function()
                          v43.CustomPhysicalProperties = PhysicalProperties.new(
                            25, 0.1, 0.9, 100, 100
                          )
                        end)
                      end
                    end

                    for key15, value35 in pairs(character9:GetDescendants()) do
                      if value35:IsA("BasePart") then
                        value35.CanCollide = true
                      end
                    end
                  end
                end)
              end
            end
          end)

          task.wait(0.1)
        end

        pcall(function()
          local v44 = f6(localPlayer)

          if v44 then
            local chaoticBV4 = v44:FindFirstChild("ChaoticBV")

            if chaoticBV4 then
              chaoticBV4:Destroy()
            end

            v44.CFrame = CFrame.new(position3)
            v44.Velocity = Vector3.new(0, 0, 0)
            v44.RotVelocity = Vector3.new(0, 0, 0)
          end

          local humanoid9 = localPlayer.Character
            and localPlayer.Character:FindFirstChildOfClass("Humanoid")

          if humanoid9 then
            humanoid9:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = humanoid9
          end

          for key16, value36 in pairs(localPlayer.Character:GetDescendants()) do
            if value36:IsA("BasePart") then
              value36.CustomPhysicalProperties = nil
            end
          end
        end)
      end)
    end
  end,
})

MainTab:Section({ Title = "Scripts" })

MainTab:Button({
  Title = "FE FLING ALL",
  Desc = "Execute FE FLING ALL",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "FE FLING ALL Executed!",
      Icon = "shield-check",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/FlingScripT/refs/heads/main/flingGG.lua.txt"))()
  end,
})

MainTab:Button({
  Title = "RE-SIZER",
  Desc = "Execute RE-SIZER Script",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "RE-SIZER Executed!",
      Icon = "alert-triangle",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/AUTH0R/refs/heads/main/size-resizer.lua"))()
  end,
})

MainTab:Button({
  Title = "FIT-COPIER",
  Desc = "Execute FIT-COPIER",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "FIT COPIER Executed!",
      Icon = "droplet-off",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/AUTH0R/refs/heads/main/HUB/FitCopier.lua"))()
  end,
})

MainTab:Button({
  Title = "FE CHAT DRAW",
  Desc = "Execute FE CHAT DRAW",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "FE CHAT DRAW Executed!",
      Icon = "droplet-off",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/FeChatdraw/refs/heads/main/FeChaTDraw.lua"))()
  end,
})

MainTab:Button({
  Title = "FE-TRAPPER",
  Desc = "Execute FE TRAPPER",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "FE TRAPPER Executed!",
      Icon = "droplet-off",
      Duration = 5,
    })

    -- ✅ Yahan par quotes aur brackets fix kar diye gaye hain
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/AUTH0R/refs/heads/main/trapperv3.lua", true))()
  end,
})

MainTab:Button({
  Title = "ChaT Bypass",
  Desc = "Execute Bypass",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "Bypass Executed!",
      Icon = "shield-check",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://https://raw.githubusercontent.com/MANASMCPE/AUTH0R/refs/heads/main/HUB/protected.lua.txt"))()
  end,
})

MainTab:Button({
  Title = "MonK Emotes",
  Desc = "Execute MonK Emotes",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "MonK Emotes Executed!",
      Icon = "shield-check",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/FeMonKEmotesBy/refs/heads/main/EmotesByMonK_Draggable_Minimize.lua"))()
  end,
})

MainTab:Button({
  Title = "Life TexT Spawner",
  Desc = "Execute TexT Spawner",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "TexT Spawner Executed!",
      Icon = "shield-check",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/AUTH0R/refs/heads/main/HUB/TexTSpawneR.lua"))()
  end,
})

MainTab:Button({
  Title = "WELD Max",
  Desc = "Execute WELD Max",
  Callback = function()
    windui:Notify({
      Title = "Success",
      Content = "WELD Max Executed!",
      Icon = "shield-check",
      Duration = 5,
    })

    loadstring(game:HttpGet("https://raw.githubusercontent.com/MANASMCPE/CelestialWeldByMonKandLisa/refs/heads/main/CELESTIAL.lua"))()
  end,
})

ProtectionTab:Section({ Title = "Protections" })
local antiCollision = false
local v45 = {}
local v46 = {}

local function f12()
  v46 = { [workspace.Terrain] = true }
  local island = workspace:FindFirstChild("Island")

  if island then
    for key17, value37 in pairs(island:GetDescendants()) do
      if value37:IsA("BasePart") then
        v46[value37] = true
      end
    end
  end

  local tower = workspace:FindFirstChild("Tower")

  if tower then
    for key18, value38 in pairs(tower:GetDescendants()) do
      if value38:IsA("BasePart") then
        v46[value38] = true
      end
    end
  end
end

local function f13()
  local character10 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
  local humanoid10 = character10:WaitForChild("Humanoid")
  local humanoidRootPart3 = character10:WaitForChild("HumanoidRootPart")

  for key19, value39 in pairs(character10:GetDescendants()) do
    if value39:IsA("BasePart") and value39.Name ~= "HumanoidRootPart" then
      value39.CanCollide = false
      value39.Massless = true
    end
  end

  for key20, value40 in pairs(humanoidRootPart3:GetChildren()) do
    if value40:IsA("BodyVelocity") or value40:IsA("BodyGyro") or value40:IsA("BodyPosition")
      or value40:IsA("BodyForce") then
      value40:Destroy()
    end
  end

  humanoid10:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
  f12()

  for key21, value41 in pairs(workspace:GetDescendants()) do
    if value41:IsA("BasePart") then
      value41.CanCollide = v46[value41] or false
    end
  end

  for key22, value42 in pairs(players:GetPlayers()) do
    if value42 ~= localPlayer and value42.Character then
      for key23, value43 in pairs(value42.Character:GetDescendants()) do
        if value43:IsA("BasePart") then
          value43.CanCollide = false
        end
      end
    end
  end

  local count = 0
  local stepped = runService.Stepped

  table.insert(v45, (stepped:Connect(function()
    if not antiCollision then
      return
    else
      count = count + 1

      for key24, value44 in pairs(character10:GetDescendants()) do
        if value44:IsA("BasePart") and value44.Name ~= "HumanoidRootPart" then
          value44.CanCollide = false
        end
      end

      if count % 10 == 0 then
        for key25, value45 in pairs(players:GetPlayers()) do
          if value45 ~= localPlayer and value45.Character then
            for key26, value46 in pairs(value45.Character:GetDescendants()) do
              if value46:IsA("BasePart") then
                value46.CanCollide = false
              end
            end
          end
        end
      end

      if humanoid10:GetState() == Enum.HumanoidStateType.Climbing then
        humanoid10:ChangeState(Enum.HumanoidStateType.Freefall)
      end

      local velocity2 = humanoidRootPart3.Velocity

      if velocity2.Magnitude > 200 then
        humanoidRootPart3.Velocity = velocity2.Unit * 200
      end

      if humanoidRootPart3.RotVelocity.Magnitude > 50 then
        humanoidRootPart3.RotVelocity = Vector3.new(0, 0, 0)
      end

      return
    end
  end)))

  local descendantAdded = character10.DescendantAdded

  table.insert(v45, (descendantAdded:Connect(function(p5)
    if not antiCollision then
      return
    end

    if p5:IsA("BasePart") and p5.Name ~= "HumanoidRootPart" then
      p5.Massless = true
      p5.CanCollide = false
    end
  end)))

  local descendantAdded2 = workspace.DescendantAdded

  table.insert(v45, (descendantAdded2:Connect(function(key27)
    if not antiCollision then
      return
    end

    if key27:IsA("BasePart") then
      local island2 = workspace:FindFirstChild("Island")
      local tower2 = workspace:FindFirstChild("Tower")

      if key27 == workspace.Terrain then
        key27.CanCollide = true
        v46[key27] = true
      elseif island2 and key27:IsDescendantOf(island2) then
        key27.CanCollide = true
        v46[key27] = true
      elseif tower2 and key27:IsDescendantOf(tower2) then
        key27.CanCollide = true
        v46[key27] = true
      else
        key27.CanCollide = false
      end
    end
  end)))

  local playerAdded = players.PlayerAdded

  table.insert(v45, (playerAdded:Connect(function(p6)
    if not antiCollision then
      return
    end

    p6.CharacterAdded:Connect(function(character11)
      task.wait(0.5)

      for key28, value47 in pairs(character11:GetDescendants()) do
        if value47:IsA("BasePart") then
          value47.CanCollide = false
        end
      end
    end)
  end)))

  task.spawn(function()
    while antiCollision and character10 and character10.Parent do
      task.wait(5)

      if antiCollision then
        f12()
      end
    end
  end)
end

local f14

function f14()
  for key29, value48 in pairs(v45) do
  end

  v45 = {}

  for key30, value49 in pairs(workspace:GetDescendants()) do
    if value49:IsA("BasePart") then
      value49.CanCollide = true
    end
  end

  if localPlayer.Character then
    for key31, value50 in pairs(localPlayer.Character:GetDescendants()) do
      if value50:IsA("BasePart") then
        value50.CanCollide = true
        value50.Massless = false
      end
    end
  end
end

ProtectionTab:Toggle({
  Title = "Anti Collision",
  Desc = "Protects against flings, black holes, etc., and others",
  Value = false,
  Callback = function(value51)
    antiCollision = value51

    if value51 then
      windui:Notify({
        Title = "Anti Collision",
        Content = "Anti Collision Enabled!",
        Icon = "shield",
        Duration = 3,
      })

      if localPlayer.Character then
        f13()
      else
        localPlayer.CharacterAdded:Connect(function()
          if antiCollision then
            f13()
          end
        end)
      end
    else
      windui:Notify({
        Title = "Anti Collision",
        Content = "Anti Collision Disabled!",
        Icon = "shield-off",
        Duration = 3,
      })

      f14()
    end
  end,
})

local antiVoid = false
local v47 = {}
local fallenPartsDestroyHeight5 = workspace.FallenPartsDestroyHeight
local v48 = -math.huge

local function f15(value52)
  local characterAdded = value52.CharacterAdded

  table.insert(v47, (characterAdded:Connect(function(p7)
    if not antiVoid then
      return
    end

    task.wait(0.5)
    local humanoid11 = p7:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart4 = p7:FindFirstChild("HumanoidRootPart")

    if not humanoid11 or not humanoidRootPart4 then
      return
    else
      humanoid11.MaxHealth = math.huge
      humanoid11.Health = math.huge

      local heartbeat = runService.Heartbeat

      table.insert(v47, (heartbeat:Connect(function()
        if not antiVoid then
          return
        end

        if p7 and p7.Parent and humanoid11 and humanoidRootPart4 then
          if humanoidRootPart4.Position.Y > v48 then
            if humanoid11.Health < math.huge then
              humanoid11.Health = math.huge
            end
          end
        end
      end)))

      local health = humanoid11:GetPropertyChangedSignal("Health")

      table.insert(v47, (health:Connect(function()
        if not antiVoid then
          return
        end

        if humanoidRootPart4.Position.Y > v48 then
          if humanoid11.Health < math.huge then
            humanoid11.Health = math.huge
          end
        end
      end)))

      return
    end
  end)))
end

local function f16()
  workspace.FallenPartsDestroyHeight = (0 / 0)
  local playerAdded2 = players.PlayerAdded

  table.insert(v47, (playerAdded2:Connect(function(p8)
    if antiVoid then
      f15(p8)
    end
  end)))

  for key32, value53 in pairs(players:GetPlayers()) do
    f15(value53)
  end

  if localPlayer.Character then
    local humanoid12 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid12 then
      humanoid12.MaxHealth = math.huge
      humanoid12.Health = math.huge
    end
  end
end

local function f17()
  for key33, value54 in pairs(v47) do
  end

  v47 = {}
  workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight5

  for key34, value55 in pairs(players:GetPlayers()) do
    if value55.Character then
      local humanoid13 = value55.Character:FindFirstChildOfClass("Humanoid")

      if humanoid13 then
        humanoid13.MaxHealth = 100
        humanoid13.Health = 100
      end
    end
  end
end

ProtectionTab:Toggle({
  Title = "Anti Void",
  Desc = "Prevents death from falling into the void",
  Value = false,
  Callback = function(value56)
    antiVoid = value56

    if value56 then
      windui:Notify({
        Title = "Anti Void",
        Content = "Anti Void Enabled!",
        Icon = "shield",
        Duration = 3,
      })

      f16()
    else
      windui:Notify({
        Title = "Anti Void",
        Content = "Anti Void Disabled!",
        Icon = "shield-off",
        Duration = 3,
      })

      f17()
    end
  end,
})

local godMode = false
local v49 = {}
local v50 = {}
local v51 = false

local function f18(character12)
  local v52 = not character12 or not godMode
  local humanoid14

  if v52 then
    return
  else
    humanoid14 = character12:FindFirstChildOfClass("Humanoid")
    local humanoidRootPart5 = character12:FindFirstChild("HumanoidRootPart")

    if humanoid14 then
      humanoid14.MaxHealth = 9000000000
      humanoid14.Health = 9000000000
      humanoid14:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
      humanoid14:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
      humanoid14:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
      humanoid14.BreakJointsOnDeath = false

      pcall(function()
        for key35, value57 in pairs(getconnections(humanoid14.HealthChanged)) do
          value57:Disable()
          table.insert(v50, { conn = value57, type = "HealthChanged", humanoid = humanoid14 })
        end

        for key36, value58 in pairs(getconnections(humanoid14.Died)) do
          value58:Disable()
          table.insert(v50, { conn = value58, type = "Died", humanoid = humanoid14 })
        end
      end)

      local heartbeat2 = runService.Heartbeat

      table.insert(v49, (heartbeat2:Connect(function()
        if not godMode then
          return
        end

        if humanoid14 and humanoid14.Parent then
          if humanoid14.Health < 9000000000 then
            humanoid14.Health = 9000000000
          end

          if humanoid14.MaxHealth < 9000000000 then
            humanoid14.MaxHealth = 9000000000
          end

          local getState = humanoid14:GetState()

          if getState == Enum.HumanoidStateType.Dead
            or getState == Enum.HumanoidStateType.FallingDown
            or getState == Enum.HumanoidStateType.Ragdoll then
            humanoid14:ChangeState(Enum.HumanoidStateType.GettingUp)
          end
        end
      end)))

      local health2 = humanoid14:GetPropertyChangedSignal("Health")

      table.insert(v49, (health2:Connect(function()
        if not godMode then
          return
        end

        if humanoid14.Health < 9000000000 then
          humanoid14.Health = 9000000000
        end
      end)))

      local maxHealth = humanoid14:GetPropertyChangedSignal("MaxHealth")

      table.insert(v49, (maxHealth:Connect(function()
        if not godMode then
          return
        end

        if humanoid14.MaxHealth < 9000000000 then
          humanoid14.MaxHealth = 9000000000
        end
      end)))
    end

    for key37, value59 in pairs(character12:GetDescendants()) do
      local v53 = value59

      if v53:IsA("BasePart") then
        pcall(function()
          for key38, value60 in pairs(getconnections(v53.Touched)) do
            value60:Disable()
            table.insert(v50, { conn = value60, type = "Touched", part = v53 })
          end
        end)
      end
    end

    if humanoidRootPart5 then
      local touched = humanoidRootPart5.Touched

      table.insert(v49, (touched:Connect(function(p9)
        if not godMode then
          return
        end

        if p9 and p9.Parent and p9.Parent ~= character12 then
          pcall(function()
            if p9:FindFirstChild("TouchInterest") then
              p9.CanTouch = false
            end
          end)
        end
      end)))
    end

    return
  end
end

local v54 = 0
local cframe5

local function f19()
  v54 = 0
  local childAdded = workspace.ChildAdded

  table.insert(v49, (childAdded:Connect(function(p10)
    if not godMode then
      return
    end

    if p10.Name == "Structure" or p10.Name == "Sandboxes" then
      if not v51 then
        v51 = true

        task.delay(0.05, function()
          pcall(function()
            if godMode and p10 and p10.Parent then
              p10:Destroy()
            end
          end)

          v51 = false
        end)
      end
    end
  end)))

  local descendantAdded3 = workspace.DescendantAdded

  table.insert(v49, (descendantAdded3:Connect(function(p11)
    if not godMode then
      return
    end

    pcall(function()
      if not p11 or not p11.Parent then
        return
      elseif p11:IsA("Explosion") then
        p11:Destroy()
        return
      elseif p11:IsA("Fire") or p11:IsA("Smoke") then
        p11:Destroy()
        return
      else
        local structure = workspace:FindFirstChild("Structure")

        if structure and p11:IsDescendantOf(structure) then
          p11:Destroy()
        end

        return
      end
    end)
  end)))

  local function f20(character13)
    local humanoid15 = character13:FindFirstChildOfClass("Humanoid")

    if humanoid15 then
      local died = humanoid15.Died

      table.insert(v49, (died:Connect(function()
        if not godMode then
          return
        end

        v54 = v54 + 1

        if v54 >= 300 then
          windui:Notify({
            Title = "God Mode",
            Content = "Death limit reached (300 kills)",
            Icon = "alert-triangle",
            Duration = 5,
          })

          return
        else
          local character14 = localPlayer.Character

          if character14 and character14:FindFirstChild("HumanoidRootPart") then
            cframe5 = character14.HumanoidRootPart.CFrame
          end

          task.wait(0.1)

          if godMode then
            localPlayer:LoadCharacter()
          end

          return
        end
      end)))
    end
  end

  if localPlayer.Character then
    f20(localPlayer.Character)
  end

  local characterAdded2 = localPlayer.CharacterAdded

  table.insert(v49, (characterAdded2:Connect(function(p12)
    if not godMode then
      return
    else
      task.wait(0.3)

      if cframe5 then
        local waitForChild = p12:WaitForChild("HumanoidRootPart", 5)

        if waitForChild then
          waitForChild.CFrame = cframe5
        end
      end

      f18(p12)
      f20(p12)
      local descendantAdded4 = p12.DescendantAdded

      table.insert(v49, (descendantAdded4:Connect(function()
        if godMode then
          f18(p12)
        end
      end)))

      return
    end
  end)))

  local heartbeat3 = runService.Heartbeat

  table.insert(v49, (heartbeat3:Connect(function()
    if not godMode then
      return
    end

    if localPlayer.Character then
      local humanoid16 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid16 then
        if humanoid16.Health < 9000000000 then
          humanoid16.Health = 9000000000
        end

        if humanoid16.MaxHealth < 9000000000 then
          humanoid16.MaxHealth = 9000000000
        end

        local getState2 = humanoid16:GetState()

        if getState2 == Enum.HumanoidStateType.Dead
          or getState2 == Enum.HumanoidStateType.FallingDown
          or getState2 == Enum.HumanoidStateType.Ragdoll then
          humanoid16:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
          humanoid16:ChangeState(Enum.HumanoidStateType.GettingUp)
          humanoid16.Health = 9000000000
        end
      end
    end
  end)))

  local stepped2 = runService.Stepped

  table.insert(v49, (stepped2:Connect(function()
    if not godMode then
      return
    end

    if localPlayer.Character then
      local humanoid17 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid17 then
        humanoid17.Health = 9000000000
        humanoid17.MaxHealth = 9000000000
      end
    end
  end)))

  local renderStepped = runService.RenderStepped

  table.insert(v49, (renderStepped:Connect(function()
    if not godMode then
      return
    end

    if localPlayer.Character then
      local humanoid18 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid18 then
        if humanoid18.Health < 9000000000 then
          humanoid18.Health = 9000000000
        end
      end
    end
  end)))

  if localPlayer.Character then
    f18(localPlayer.Character)
  end
end

local f21

local function f22()
  v51 = false
  v54 = 0

  for key39, value61 in pairs(v49) do
  end

  v49 = {}
  f21()

  if localPlayer.Character then
    local humanoid19 = localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid19 then
      humanoid19.MaxHealth = 100
      humanoid19.Health = 100
      humanoid19:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
      humanoid19:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
      humanoid19:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
      humanoid19.BreakJointsOnDeath = true
    end

    for key40, value62 in pairs(localPlayer.Character:GetDescendants()) do
      if value62:IsA("BasePart") then
        value62.CanTouch = true
      end
    end
  end

  cframe5 = nil
  task.wait(0.5)
end

function f21()
  for key41, value63 in pairs(v50) do
  end

  v50 = {}
end

ProtectionTab:Toggle({
  Title = "God Mode",
  Desc = "Deletes natural phenomena, parts that cause damage, etc..",
  Value = false,
  Callback = function(value64)
    godMode = value64

    if value64 then
      windui:Notify({
        Title = "God Mode",
        Content = "God Mode Enabled.",
        Icon = "shield",
        Duration = 5,
      })

      f19()
    else
      windui:Notify({
        Title = "God Mode",
        Content = "God Mode Disabled.",
        Icon = "shield-off",
        Duration = 3,
      })

      f22()
    end
  end,
})