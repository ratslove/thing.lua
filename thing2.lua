if game.PlaceId == 155615604 then
    local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
    local folder = Instance.new("Folder")
    folder.Name = "Storage"
    folder.Parent = Game

    local States = {}
    
    local win = lib:Window("Oasis Hub - Prison Life",Color3.fromRGB(233, 125, 245), Enum.KeyCode)
    
    local maintab = win:Tab('Local Player')
    local charactertab = win:Tab('Combat')
    local gametab = win:Tab('Game')
    local teamtab = win:Tab('Teams')
    local misctab = win:Tab('Misc')
    local teletab = win:Tab('Teleports')
    local uitab = win:Tab('UI')
    local credstab = win:Tab('Credits')

    IYMouse = game.Players.LocalPlayer:GetMouse()

    function getRoot(char)
        local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end
    
    function isNumber(str)
        if tonumber(str) ~= nil or str == 'inf' then
            return true
        end
    end

    FLYING = false
    QEfly = true
    iyflyspeed = 3
    vehicleflyspeed = 3
    function sFLY(vfly)
        repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        repeat wait() until IYMouse
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

        local T = getRoot(game.Players.LocalPlayer.Character)
        local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local SPEED = 0

        local function FLY()
            FLYING = true
            local BG = Instance.new('BodyGyro')
            local BV = Instance.new('BodyVelocity')
            BG.P = 9e4
            BG.Parent = T
            BV.Parent = T
            BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.cframe = T.CFrame
            BV.velocity = Vector3.new(0, 0, 0)
            BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
            task.spawn(function()
                repeat wait()
                    if not vfly and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                    end
                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                        SPEED = 0
                    end
                    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                        lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    else
                        BV.velocity = Vector3.new(0, 0, 0)
                    end
                    BG.cframe = workspace.CurrentCamera.CoordinateFrame
                until not FLYING
                CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                SPEED = 0
                BG:Destroy()
                BV:Destroy()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                end
            end)
        end
        flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 's' then
                CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'a' then
                CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'd' then 
                CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
            elseif QEfly and KEY:lower() == 'e' then
                CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
            elseif QEfly and KEY:lower() == 'q' then
                CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
            end
            pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
        end)
        flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            elseif KEY:lower() == 'e' then
                CONTROL.Q = 0
            elseif KEY:lower() == 'q' then
                CONTROL.E = 0
            end
        end)
        FLY()
    end

    function NOFLY()
        FLYING = false
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
    end
    
    local var = {
        ['Player'] = {
            ['WalkSpeed'] = 16,
            ['JumpPower'] = 50
        }
    }
    
    maintab:Textbox('WalkSpeed', false, function(value1)    
        
        var.Player.WalkSpeed = value1
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value1

        game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid")
            char.Humanoid.WalkSpeed = var.Player.WalkSpeed
        end)

        game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(prop)
            if prop == "WalkSpeed" and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= var.Player.WalkSpeed then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = var.Player.WalkSpeed
            end
        end)

        game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        
            char:WaitForChild("Humanoid")
            char.Humanoid.Changed:Connect(function(prop)
                if prop == "WalkSpeed" and char.Humanoid.WalkSpeed ~= var.Player.WalkSpeed then
                    char.Humanoid.WalkSpeed = var.Player.WalkSpeed
                end
            end)

        end)
    
    end)
    
    maintab:Textbox('JumpPower', false, function(value2)
    
        var.Player.JumpPower = value2
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value2

        game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid")
            char.Humanoid.JumpPower = var.Player.JumpPower
        end)

        game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(prop)
            if prop == "JumpPower" and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= var.Player.JumpPower then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = var.Player.JumpPower
            end
        end)
    
    end)
    
    maintab:Textbox('Field of View', false, function(amount)
        
        game:GetService'Workspace'.Camera.FieldOfView = amount
    
    end)

    maintab:Toggle('NoClip', false, function(value)
    
        getgenv().nokiz = value
        if getgenv().nokiz == true then

            _G.Noclips = true

            game:GetService("RunService").Stepped:Connect(function()
                if _G.Noclips then
                    pcall(function()
                        game.Players.LocalPlayer.Character:FindFirstChild("Head").CanCollide = false
                        game.Players.LocalPlayer.Character:FindFirstChild("Torso").CanCollide = false
                    end)
                end
            end)

        else if getgenv().nokiz == false then
            _G.Noclips = false
            
            end
        end
    end)
    
    maintab:Toggle('Infinite Jump', false, function(value)

        getgenv().infjumper = value
        
        if getgenv().infjumper == true then
            
            _G.infinjump = true
            
            local Player = game:GetService("Players").LocalPlayer
            local Mouse = Player:GetMouse()
            Mouse.KeyDown:connect(function(k)
                if _G.infinjump then
                    if k:byte() == 32 then
                        Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        Humanoid:ChangeState("Jumping")
                    end
                end
            end)
    
            else if getgenv().infjumper == false then
                    
                _G.infinjump = false
                
            end
        end
    
    end)
    
    maintab:Toggle('Fly', false, function(value, args)
    
        getgenv().flyerwow = value

        if getgenv().flyerwow == true then
            
            NOFLY()
            wait()
            sFLY()
            if args[1] and isNumber(args[1]) then
                iyflyspeed = args[1]
            end
            
            else if getgenv().flyerwow == false then
                NOFLY()
                
            end
        end
    
    end)
    
    maintab:Textbox('Fly Speed', false, function(value)

		iyflyspeed = value
    
    end)

    maintab:Toggle('Vehicle Fly', false, function(value, args)
    
        getgenv().flyerwow2 = value

        if getgenv().flyerwow2 == true then
            
            NOFLY()
            wait()
            sFLY(true)
            if args[1] and isNumber(args[1]) then
                vehiclespeed = args[1]
                end
            
            else if getgenv().flyerwow2 == false then
                NOFLY()
                
            end
        end
    
    end)

    maintab:Textbox('Vehicle Fly Speed', false, function(value)

		vehicleflyspeed = value
    
    end)
    
    charactertab:Button('Gun Grabber', function()
    
        local BuyGamepass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(tonumber((game:GetService("Players").LocalPlayer.CharacterAppearance):split('=')[#((game:GetService("Players").LocalPlayer.CharacterAppearance):split('='))]), 96651)
        if BuyGamepass then
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
        else
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
        end
    
end)

charactertab:Dropdown("Gun Mods",{"M9", "Remington 870", "AK-47"}, function(v)
    
    local module = nil
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v) then
        module = require(game:GetService("Players").LocalPlayer.Backpack[v].GunStates)
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(v) then
        module = require(game:GetService("Players").LocalPlayer.Character[v].GunStates)
    end
    if module ~= nil then
        module["MaxAmmo"] = math.huge
        module["CurrentAmmo"] = math.huge
        module["FireRate"] = 0.01
        module["ReloadTime"] = 0.000001
        module["AutoFire"] = true
    end

end)

charactertab:Toggle('Respawn with Guns', false, function(value)
    
    getgenv().resgun = value
    if getgenv().resgun == true then 
        _G.Auto_Guns = true
        
        game.Players.LocalPlayer.CharacterAdded:Connect(function()
            if _G.Auto_Guns then
                pcall(function()
                    if BuyGamepass then
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP)
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
                    else
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
                        workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
                    end
                end)
            end
        end)
    else if getgenv().resgun == false then
        _G.Auto_Guns = false

    end
end
end)
    
    charactertab:Toggle('Instant Respawn', false, function(value)
        
        getgenv().instre = value
    if getgenv().instre == true then 
        _G.Loop = true
        
            while _G.Loop == true do
                wait()
                if game.Players.LocalPlayer.Character.Humanoid.Health <= 15 then
                    local location = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    local A_1 = "\66\114\111\121\111\117\98\97\100\100"
                    local Event = game:GetService("Workspace").Remote.loadchar
                    Event:InvokeServer(A_1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = location
                end
            end
    
    
    else if getgenv().instre == false then
        
    _G.Loop = false
        
            while _G.Loop == true do
                wait()
                if game.Players.LocalPlayer.Character.Humanoid.Health <= 15 then
                    local A_1 = "\66\114\111\121\111\117\98\97\100\100"
                    local Event = game:GetService("Workspace").Remote.loadchar
                    Event:InvokeServer(A_1)
                end
            end
    end
        end
    
    end)

    charactertab:Toggle('Infinite Stamina', false, function(value)
    
        stamina_thing = value
    
        if stamina_thing == true then
            
            lib:Notification('Alert', 'This feature is currently disabled.', 'Close')

            print("Infinite Stamina: On")
            
            
            else if stamina_thing == false then
                
                print("Infinite Stamina: Off")
                
            end
        end

    end)

charactertab:Toggle('Kill Aura', false, function(value)

getgenv().killauralol = value
if getgenv().killauralol == true then

    States.Kill_Aura = true

else if getgenv().killauralol == false then

    States.Kill_Aura = false

    end
end

end)

coroutine.wrap(function()
	while wait() do
		if States.Kill_Aura then
                for i, e in pairs(game.Players:GetChildren()) do
                    if e ~= game.Players.LocalPlayer then
                        local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                        meleeEvent:FireServer(e)                                     
                    end 
                end 
            end 
		end
end)()

charactertab:Toggle('Anti Void', false, function(value)

    getgenv().antiviv = value
    if getgenv().antiviv == true then

        States.Anti_Void = true
		
		while wait() do
			if States.Anti_Void then
				pcall(function()
					if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y < 1 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(888, 100, 2388)
					end
				end)
			end
		end

    else if getgenv().antiviv == false then

        States.Anti_Void = false

        end
    end

end)

charactertab:Toggle('Super Punch', false, function(value)
    
    getgenv().superpuncher = value
    if getgenv().superpuncher == true then

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local MeleeEvent = ReplicatedStorage:FindFirstChild("meleeEvent")
		local Mouse = game.Players.LocalPlayer:GetMouse()
		local Punch = false
		local Cooldown = false
		States.SuperPunch = true

		local function Punch()
			if not States.Fast_Punch then
				Cooldown = true
				local Part = Instance.new("Part", game.Players.LocalPlayer.Character)
				Part.Transparency = 1
				Part.Size = Vector3.new(5, 2, 3)
				Part.CanCollide = false
				local Weld = Instance.new("Weld", Part)
				Weld.Part0 = game.Players.LocalPlayer.Character.Torso
				Weld.Part1 = Part
				Weld.C1 = CFrame.new(0, 0, 2)
				Part.Touched:connect(function(Touch)
					if game.Players:FindFirstChild(Touch.Parent.Name) then
						local plr = game.Players:FindFirstChild(Touch.Parent.Name) 
						if plr.Name ~= game.Players.LocalPlayer.Name then
							Part:Destroy()
							for i = 1,100 do
								MeleeEvent:FireServer(plr)
							end
						end
					end
				end)
				wait(0.9)
				Cooldown = false
				Part:Destroy()
			else
				Cooldown = true
				local Part = Instance.new("Part", game.Players.LocalPlayer.Character)
				Part.Transparency = 1
				Part.Size = Vector3.new(5, 2, 3)
				Part.CanCollide = false
				local Weld = Instance.new("Weld", Part)
				Weld.Part0 = game.Players.LocalPlayer.Character.Torso
				Weld.Part1 = Part
				Weld.C1 = CFrame.new(0, 0, 2)
				Part.Touched:connect(function(Touch)
					if game.Players:FindFirstChild(Touch.Parent.Name) then
						local plr = game.Players:FindFirstChild(Touch.Parent.Name) 
						if plr.Name ~= game.Players.LocalPlayer.Name then
							Part:Destroy()
							for i = 1,100 do
								MeleeEvent:FireServer(plr)
							end
						end
					end
				end)
				wait(0.1)
				Cooldown = false
				Part:Destroy()
			end
		end
		Mouse.KeyDown:connect(function(Key)
			if not Cooldown and States.SuperPunch then
				if Key:lower() == "f" then
					Punch()
				end				
			end
		end)

    
    else if getgenv().superpuncher == false then

        States.SuperPunch = false

    end
end

end)

charactertab:Toggle('Fast Punch', false, function(value)

    getgenv().fastpunch = value
    if getgenv().fastpunch == true then

        States.Fast_Punch = true

    else if getgenv().fastpunch == false then
        States.Fast_Punch = false

    end
end

spawn(function()
	while wait() do
		if States.Fast_Punch == true then
			pcall(function()
				getsenv(game.Players.LocalPlayer.Character.ClientInputHandler).cs.isFighting = false
			end)
		end
	end
end)


end)

gametab:Toggle('Remove Prison Doors', false, function(value)
    
    getgenv().door = value
    if getgenv().door == true then 
        for i,v in pairs(Workspace:GetChildren()) do
            if v.Name == "Doors" then
                v.Parent = folder
            end
        end

    else if getgenv().door == false then
        for i,v in pairs(game.Storage:GetChildren()) do
            if v.Name == "Doors" then
                v.Parent = Workspace
            end
        end
    end
end

end)

gametab:Toggle('Remove Prison Cells', false, function(value)
    
    getgenv().cell = value
    if getgenv().cell == true then 
        for i,v in pairs(Workspace.Prison_Cellblock:GetChildren()) do
            if v.Name == "doors" then
                v.Parent = folder
            end
        end
    
    else if getgenv().cell == false then
        for i,v in pairs(game.Storage:GetChildren()) do
            if v.Name == "doors" then
                v.Parent = Workspace.Prison_Cellblock
            end
        end
    end
    end
    
end)

gametab:Toggle('Remove Prison Fences', false, function(value)
    
    getgenv().fence = value
    if getgenv().fence == true then 
        for i,v in pairs(Workspace:GetChildren()) do
            if v.Name == "Prison_Fences" then
                v.Parent = folder
            end
        end

    else if getgenv().fence == false then
        for i,v in pairs(game.Storage:GetChildren()) do
            if v.Name == "Prison_Fences" then
                v.Parent = Workspace
            end
        end
    end
end

end)
    
    teamtab:Button('Be Prisoner', function()
    
        Workspace.Remote.TeamEvent:FireServer("Bright orange")
    
        if game.Players.LocalPlayer.Neutral == true then
            game.Players.LocalPlayer.Neutral = false
        end

        lib:Notification("Success", "You are now on the 'Prisoners' team.", "Close") -- (header, text, closebutton) --
        
    end)
    
    teamtab:Button('Be Guard', function()
    
        Workspace.Remote.TeamEvent:FireServer("Bright blue")
    
        if game.Players.LocalPlayer.Neutral == true then
            game.Players.LocalPlayer.Neutral = false
        end

        lib:Notification("Success", "You are now on the 'Guards' team.", "Close") -- (header, text, closebutton) --
    
    end)
    
    teamtab:Button('Be Criminal', function()
    
        LCS = game.Workspace["Criminals Spawn"].SpawnLocation
    
        LCS.CanCollide = false
        LCS.Size = Vector3.new(51.05, 24.12, 54.76)
        LCS.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        LCS.Transparency = 1
        wait(0.5)
        LCS.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        LCS.Size = Vector3.new(6, 0.2, 6)
        LCS.Transparency = 0
    
        if game.Players.LocalPlayer.Neutral == true then
            game.Players.LocalPlayer.Neutral = false
        end

        lib:Notification("Success", "You are now on the 'Criminal' team.", "Close") -- (header, text, closebutton) --
    
    end)
    
    teamtab:Button('Be Neutral', function()
    
        local savedcf = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local savedcamcf = game.Workspace.CurrentCamera.CFrame
		game.Workspace.Remote.loadchar:InvokeServer(nil, BrickColor.new("Bright red").Name)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedcf
		game.Workspace.CurrentCamera.CFrame = savedcamcf

        lib:Notification("Success", "You are now on the 'Neutral' team.", "Close") -- (header, text, closebutton) --
    
    end)
    
    misctab:Button('Reset Character', function()
        
        game.Players.LocalPlayer.Character:BreakJoints()

        lib:Notification("Notification", "Successfully died!", "Close") -- (header, text, closebutton) --
    end)

    misctab:Button('Rejoin Server', function()
    
        local ts = game:GetService("TeleportService")
    
        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)

    misctab:Button('Server Hop', function()
    
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
    		if v.playing ~= v.maxPlayers then
    			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
    		end
    	end


    end)
    
    misctab:Button('Arrest All', function()
    
        wait(0.1)
        Player = game.Players.LocalPlayer
        Pcf = Player.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
        if v.Name ~= Player.Name then
        local i = 10
        repeat
        wait()
        i = i-1
        game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
        Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
        until i == 0
    end
    end

    lib:Notification("Notification", "Arresting Criminals..", "Close") -- (header, text, closebutton) --
        
    end)

    misctab:Button('Builder Tools (BTools)', function()
    
        local tool1 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool2 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool3 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool4 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool5 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        tool1.BinType = "Clone"
        tool2.BinType = "GameTool"
        tool3.BinType = "Hammer"
        tool4.BinType = "Script"
        tool5.BinType = "Grab"

        lib:Notification("Success", "Granted BTools!", "Close") -- (header, text, closebutton) --
    
    end)

    misctab:Button('Grab Keycard', function()
    
        local args = {
            [1] = workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP
        }
        
        workspace.Remote.ItemHandler:InvokeServer(unpack(args))
    
end)

teletab:Dropdown('Teleports', {"Cell Room", "Cafeteria", "Guard Spawn", "Prison Courtyard", "Prison Garage", "Prison Gate", "Criminal Base", "City"}, function(v)

    nigerian = v
    
    if nigerian == "Cell Room" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(916, 99.9899673, 2448, 1, -1.70197954e-08, -3.39260277e-14, 1.70197954e-08, 1, 7.21635587e-08, 3.26978197e-14, -7.21635587e-08, 1)

    else if nigerian == "Cafeteria" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(932.999695, 99.9899368, 2288.99463, 0.999998569, 1.30449251e-08, -0.00168087881, -1.29614106e-08, 1, 4.96959665e-08, 0.00168087881, -4.96741102e-08, 0.999998569)
    
    else if nigerian == "Guard Spawn" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(834, 98.5170059, 2316.00708, 0.999998569, -1.23378059e-05, 0.00167511462, 1.98490895e-07, 0.999973774, 0.00724552013, -0.00167516002, -0.00724550989, 0.999972343)

    else if nigerian == "Prison Courtyard" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(778.999939, 97.9999237, 2472.00391, 0.999999762, -1.46142091e-11, 0.000683857477, -1.34698882e-12, 1, 2.33399469e-08, -0.000683857477, -2.33399415e-08, 0.999999762)
    
    else if nigerian == "Prison Garage" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(582.738281, 98.039917, 2482.43945, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    
    else if nigerian == "Prison Gate" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(468, 98.1899872, 2252.00122, 1, -9.38789758e-12, 0.000121457255, 4.76451864e-12, 1, 3.80658918e-08, -0.000121457255, -3.80658918e-08, 1)
    
    else if nigerian == "Criminal Base" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-921, 92.5015793, 2190.9978, 0.999999285, -2.92056484e-06, -0.00126135349, -8.70204531e-08, 0.999997139, -0.00238165935, 0.00126135349, 0.00238165748, 0.999996424)
    
    else if nigerian == "City" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-361, 54.5028076, 1733.99707, 0.999998748, -4.78906168e-06, -0.00160547963, 1.38837322e-07, 0.999995828, -0.00289654895, 0.00160548685, 0.00289654522, 0.999994576)
    
    
    
    end
    end
    end
    end
    end
    end
    end
    end

end)
    
    uitab:Colorpicker("Change UI Color",Color3.fromRGB(233, 125, 245), function(t)
        lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
    end)
    
    credstab:Label('Owner/Founder: Grant1ed#4919')
    credstab:Label('Lead Developer/Scripter: Ducky#3566')
    
    credstab:Button("Copy Discord Invite", function()
        
        setclipboard("https://discord.gg/t2wWA3hph3")
        lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
    
    end)

    _G.fixFrame = true
    while _G.fixFrame == true do
        game.Players.LocalPlayer.PlayerGui.Home.fadeFrame.BackgroundTransparency = 1.000
        wait()
    end
    
    elseif game.PlaceId == 3956818381 then
        local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
    local win = lib:Window("Oasis Hub - Ninja Legends",Color3.fromRGB(233, 255, 107), Enum.KeyCode)
    
    local maintab = win:Tab('Islands')
    local maintab2 = win:Tab('Islands 2')
    local charactertab = win:Tab('Main')
    local areatab = win:Tab('Areas')
    local misctab = win:Tab('Misc')
    local elementtab = win:Tab('Elements')
    local uitab = win:Tab('UI')
    local credstab = win:Tab('Credits')
    
    maintab:Button('Enchanted Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80, 766, -188)
    
    end)
    
    maintab:Button('Mythical Souls Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 39439, 173)
    
    end)
    
    maintab:Button('Winter Wondlerland Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183, 46010, 36)
    
    end)
    
    maintab:Button('Dragon Legend Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188, 59594, 24)
    
    end)
    
    maintab:Button('Golden Master Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166, 52607, 34)
    
    end)
    
    maintab:Button('Midnight Shadow Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(180, 33206, 28)
    
    end)
    
    maintab:Button('Astral Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 2013, 331)
    
    end)
    
    maintab:Button('Mystical Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(165, 4047, 51)
    
    end)
    
    maintab:Button('Space Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186, 5656, 76)
    
    end)
    
    maintab:Button('Tundra Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(189, 9284, 31)
    
    end)
    
    maintab2:Button('Sandstorm Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135, 17686, 61)
    
    end)
    
    maintab2:Button('Ancient Inferno Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171, 28255, 39)
    
    end)
    
    maintab2:Button('Eternal Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139, 13680, 74)
    
    end)
    
    maintab2:Button('Thunderstorm Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108, 24069, 84)
    
    end)
    
    maintab2:Button('Cybernetic Legends Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226, 66669, 15)
    
    end)
    
    maintab2:Button('Skystorm Ultraus Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(197, 70270, 8)
    
    end)
    
    maintab2:Button('Chaos Legends Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(119, 74442, 52)
    
    end)
    
    charactertab:Toggle('Auto Belt', false, function(v)
    
        getgenv().buybelts = v
        while true do
            if not getgenv().buybelts then return end
            local A_1 = "buyAllBelts"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    
    
    end)
    
    charactertab:Toggle('Auto Sword', false, function(v)
    
        getgenv().buyswords = v
        while true do
            if not getgenv().buyswords then return end
            local A_1 = "buyAllSwords"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    
    end)
    
    charactertab:Toggle('Auto Swing', false, function(v)
    
        getgenv().autoswing = v
        while true do 
            if not getgenv().autoswing then return end
            for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:FindFirstChild("ninjitsuGain") then 
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    break
                end
            end
            local A_1 = "swingKatana"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1)
            wait(0.1)
        end    
    end)
    
    charactertab:Toggle('Auto Sell', false, function(v)
    
        getgenv().autosell = v
        while true do
            if getgenv().autoswing == false then return end
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait(0.1)
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0)
            wait(0.1)
        end
    
    end)
    
    charactertab:Button('Unlock All Islands', function()
    
        local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        for _,v in pairs(game:GetService("Workspace").islandUnlockParts:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.3)
        end
        wait(0.3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe

        
    
    end)
    
    areatab:Button('Mystical Waters', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(344, 8824, 125)
    
    end)
    
    areatab:Button('Lava Pit', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 12952, 274)
    
    end)
    
    areatab:Button('Tornado', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(320, 16872, -17)
    
    end)
    
    areatab:Button('Sword of Legends', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1831, 38, -140)
    
    end)
    
    areatab:Button('Sword of Ancients', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(613, 38, 2411)
    
    end)
    
    areatab:Button('Elemental Tornado', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(323, 30383, -10)
    
    end)
    
    areatab:Button('Fallen Infinity Blade', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1859, 38, -6788)
    
    end)
    
    areatab:Button('Zen Masters Blade', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5019, 38, 1614)
    
    end)
    
    misctab:Button('Infinity Stats Dojo', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4109.91553, 122.94751, -5908.6845)
    
    end)
    
    misctab:Button('Altar of Elements', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(732.294434, 122.947517, -5908.3461)
    
    end)
    
    misctab:Button('Pet Cloning Altar', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4520.91943, 122.947517, 1401.6312)
    
    end)
    
    misctab:Button('King of the Hill', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227.120529, 89.8075867, -285.06219)
    
    end)
    
    misctab:Button('Anti Kick', function()
    
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    
    end)
    
    elementtab:Button('Frost Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Frost")
    
    end)
    
    elementtab:Button('Electral Chaos Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Electral Chaos")
    
    end)
    
    elementtab:Button('Lightning Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Lightning")
    
    end)
    
    elementtab:Button('Inferno Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Inferno")
    
    end)
    
    elementtab:Button('Masterful Wrath Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Masterful Wrath")
    
    end)
    
    elementtab:Button('Shadow Charge Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadow Charge")
    
    end)
    
    elementtab:Button('Shadowfire Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadowfire")
    
    end)
    
    elementtab:Button('Eternity Storm Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Eternity Storm")
    
    end)
    
    elementtab:Button('Soul Fusion Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(193, 79746, 18)
    
    end)
    
    uitab:Button('Rejoin Server', function()
    
        local ts = game:GetService("TeleportService")
    
        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)
    
    uitab:Colorpicker("Change UI Color",Color3.fromRGB(233, 255, 107), function(t)
        lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
    end)
    
    credstab:Label('Owner/Founder: Grant1ed#4919')
    credstab:Label('Lead Developer/Scripter: Ducky#3566')
    
    credstab:Button("Copy Discord Invite", function()
        
        setclipboard("https://discord.gg/t2wWA3hph3")
        lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
    
    end)
    
    elseif game.PlaceId == 2788229376 then
        local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
        local win = lib:Window("Oasis Hub - Da Hood",Color3.fromRGB(255, 156, 107), Enum.KeyCode)
        
        local maintab = win:Tab("Main")
        
        maintab:Label('This script is outdated, sorry!')
    
    elseif game.PlaceId == 4842364293 then

        local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50

States = {}

local win = lib:Window("Oasis Hub - Guesty",Color3.fromRGB(247, 84, 84), Enum.KeyCode)
        
local maintab = win:Tab("Local Player")
local gametab = win:Tab("Game")
local esptab = win:Tab("ESP")
local uitab = win:Tab("User-Interface")
local credstab = win:Tab("Credits")

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

IYMouse = game.Players.LocalPlayer:GetMouse()

    function getRoot(char)
        local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end

    FLYING = false
    QEfly = true
    iyflyspeed = 1
    vehicleflyspeed = 1
    function sFLY(vfly)
        repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        repeat wait() until IYMouse
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

        local T = getRoot(game.Players.LocalPlayer.Character)
        local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local SPEED = 0

        local function FLY()
            FLYING = true
            local BG = Instance.new('BodyGyro')
            local BV = Instance.new('BodyVelocity')
            BG.P = 9e4
            BG.Parent = T
            BV.Parent = T
            BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.cframe = T.CFrame
            BV.velocity = Vector3.new(0, 0, 0)
            BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
            task.spawn(function()
                repeat wait()
                    if not vfly and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                    end
                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                        SPEED = 0
                    end
                    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                        lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    else
                        BV.velocity = Vector3.new(0, 0, 0)
                    end
                    BG.cframe = workspace.CurrentCamera.CoordinateFrame
                until not FLYING
                CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                SPEED = 0
                BG:Destroy()
                BV:Destroy()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                end
            end)
        end
        flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 's' then
                CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'a' then
                CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'd' then 
                CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
            elseif QEfly and KEY:lower() == 'e' then
                CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
            elseif QEfly and KEY:lower() == 'q' then
                CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
            end
            pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
        end)
        flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            elseif KEY:lower() == 'e' then
                CONTROL.Q = 0
            elseif KEY:lower() == 'q' then
                CONTROL.E = 0
            end
        end)
        FLY()
    end

    function NOFLY()
        FLYING = false
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
    end

local var = {
    ['Player'] = {
        ['WalkSpeed'] = 16,
        ['JumpPower'] = 50
    }
}

maintab:Slider('WalkSpeed', 16, 50, 16, function(value1)    
        
    var.Player.WalkSpeed = value1
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value1

    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        char.Humanoid.WalkSpeed = var.Player.WalkSpeed
    end)

    game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(prop)
        if prop == "WalkSpeed" and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= var.Player.WalkSpeed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = var.Player.WalkSpeed
        end
    end)

end)

maintab:Slider('JumpPower', 50, 150, 50, function(value2)
    
    var.Player.JumpPower = value2
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value2

    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        char.Humanoid.JumpPower = var.Player.JumpPower
    end)

    game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(prop)
        if prop == "JumpPower" and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= var.Player.JumpPower then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = var.Player.JumpPower
        end
    end)

end)

maintab:Slider('Field of View', 70, 120, 70, function(amount)
        
    game:GetService'Workspace'.Camera.FieldOfView = amount

end)

maintab:Toggle('Infinite Jump', false, function(value)

    getgenv().infjumper = value
    
    if getgenv().infjumper == true then
        
        _G.infinjump = true
        
        local Player = game:GetService("Players").LocalPlayer
        local Mouse = Player:GetMouse()
        Mouse.KeyDown:connect(function(k)
            if _G.infinjump then
                if k:byte() == 32 then
                    Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    Humanoid:ChangeState("Jumping")
                end
            end
        end)

        else if getgenv().infjumper == false then
                
            _G.infinjump = false
            
        end
    end

end)

local NoClipping = nil
floatName = randomString()

function NoclipLoop()
    if Clip == false and speaker.Character ~= nil then
        for _, child in pairs(speaker.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                child.CanCollide = false
            end
        end
    end
end

maintab:Toggle('NoClip', false, function(value)

    getgenv().nokiz = value
        if getgenv().nokiz == true then

            Clip = false
            wait(0.1)
            local function NoclipLoop()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                            child.CanCollide = false
                        end
                    end
                end
            end
            Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)

        else if getgenv().nokiz == false then

            if Noclipping then
                Noclipping:Disconnect()
            end
            Clip = true
        
        end
    end 

end)

maintab:Toggle('Fly', false, function(value)
    
    getgenv().flyerwow = value

    if getgenv().flyerwow == true then
        
        NOFLY()
        wait()
        sFLY()
        
        else if getgenv().flyerwow == false then
            NOFLY()
            
        end
    end

end)

gametab:Toggle('Fix Lighting', false, function(value)
    
    getgenv().autoLight = value

    if getgenv().autoLight == true then

        _G.fixLight = true
        while _G.fixLight == true do
            game.Lighting.FogEnd = 100000
            wait()
        end


    else if getgenv().autoLight == false then

        _G.fixLight = false
        while _G.fixLight == true do
            game.Lighting.FogEnd = 100000
            wait()
        end

        game.Lighting.FogEnd = 85
        
        end
    end

end)

gametab:Toggle('Auto Skip Scene', false, function(value)

    getgenv().autoSkip = value
    
    if getgenv().autoSkip == true then

        _G.autoSkiper = true
        while _G.autoSkiper == true do 
            game:GetService("ReplicatedStorage").Events.SkipScene:FireServer()
            wait()
        end


    else if getgenv().autoSkip == false then

        _G.autoSkiper = false
        while _G.autoSkiper == true do
            game:GetService("ReplicatedStorage").Events.SkipScene:FireServer()
            wait()
        end

        end
    end

end)

gametab:Button('Grab Coins', function()  

    getgenv().autoCoin = true

    spawn(function()
    
        local HR = game.Players.LocalPlayer.Character.HumanoidRootPart -- Players Head
            while wait() do
                if not getgenv().autoCoin then break end
                
                for i, v in pairs(game:GetService("Workspace").Coins:GetDescendants()) do
                    if v.Name == "TouchInterest" and v.Parent then
                        -- Fire the FireTouchInterest below.
                        firetouchinterest(HR, v.Parent, 0)
                    end
                end
            end

            for i, v in pairs(game.Workspace.Coins:DescendantAdded()) do
                if v.Name == "TouchInterest" and v.Parent then
                    -- Fire the thing again.
                    firetouchinterest(HR, v.Parent, 0)
                end
            end
        
    end)

end)

gametab:Button('Rejoin Server', function()
    
    local ts = game:GetService("TeleportService")

    local p = game:GetService("Players").LocalPlayer

    ts:Teleport(game.PlaceId, p)

end)

gametab:Button('Server Hop', function()
    
    local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for i,v in pairs(Servers.data) do
        if v.playing ~= v.maxPlayers then
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
        end
    end


end)

getgenv().cham = false
getgenv().nameESP = false
getgenv().boxESP = false


getgenv().esp_loaded = false
getgenv().Visibility = false

esptab:Toggle('Toggle ESP', false, function(value)

    if getgenv().esp_loaded == false and value == true then
        getgenv().esp_loaded = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
    end
    getgenv().Visibility = value   

end)

esptab:Toggle('Name ESP', false, function(value)

    if getgenv().esp_loaded == false and value == true then
        getgenv().esp_loaded = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
    end
    getgenv().nameESP = value   

end)

esptab:Toggle('Box ESP', false, function(value)

    if getgenv().esp_loaded == false and value == true then
        getgenv().esp_loaded = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
    end
    getgenv().boxESP = value   

end)

uitab:Colorpicker("Change UI Color",Color3.fromRGB(247, 84, 84), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

credstab:Label('Owner/Founder: Grant1ed#4919')
    credstab:Label('Lead Developer/Scripter: Ducky#3566')
    
credstab:Button("Copy Discord Invite", function()
        
    setclipboard("https://discord.gg/t2wWA3hph3")
    lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
    
end)

else if game.PlaceId == 1962086868 or 7227293156 or 3582763398 or 5253186791 then

    local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()

    local folder = Instance.new("Folder")

    folder.Name = "Storage"
    folder.Parent = game

    States = {}

    local win = lib:Window("Oasis Hub - Tower of Hell (TOH)",Color3.fromRGB(93, 143, 194), Enum.KeyCode)
        
    local maintab = win:Tab("Local Player")
    local utiltab = win:Tab("Utilities")
    local uitab = win:Tab("User-Interface")
    local credstab = win:Tab("Credits")

    function randomString()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
        array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
    end

    IYMouse = game.Players.LocalPlayer:GetMouse()

    function getRoot(char)
        local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end

    FLYING = false
    QEfly = true
    iyflyspeed = 1
    vehicleflyspeed = 1
    function sFLY(vfly)
        repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        repeat wait() until IYMouse
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

        local T = getRoot(game.Players.LocalPlayer.Character)
        local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local SPEED = 0

        local function FLY()
            FLYING = true
            local BG = Instance.new('BodyGyro')
            local BV = Instance.new('BodyVelocity')
            BG.P = 9e4
            BG.Parent = T
            BV.Parent = T
            BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.cframe = T.CFrame
            BV.velocity = Vector3.new(0, 0, 0)
            BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
            task.spawn(function()
                repeat wait()
                    if not vfly and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                    end
                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                        SPEED = 0
                    end
                    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                        lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    else
                        BV.velocity = Vector3.new(0, 0, 0)
                    end
                    BG.cframe = workspace.CurrentCamera.CoordinateFrame
                until not FLYING
                CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                SPEED = 0
                BG:Destroy()
                BV:Destroy()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                end
            end)
        end
        flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 's' then
                CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'a' then
                CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'd' then 
                CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
            elseif QEfly and KEY:lower() == 'e' then
                CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
            elseif QEfly and KEY:lower() == 'q' then
                CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
            end
            pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
        end)
        flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            elseif KEY:lower() == 'e' then
                CONTROL.Q = 0
            elseif KEY:lower() == 'q' then
                CONTROL.E = 0
            end
        end)
        FLY()
    end

    function NOFLY()
        FLYING = false
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
    end

    local reg = getreg()
 
    for i, Function in next, reg do
        if type(Function) == 'function' then
            local info = getinfo(Function)
 
            if info.name == 'kick' then
                if (hookfunction(info.func, function(...)end)) then
                    print'succesfully hooked kick'
                else
                    print'failed to hook kick'
                end
            end
        end
    end
 
    local script1 = game.StarterPlayer.StarterPlayerScripts.LocalScript
    local script2 = game.StarterPlayer.StarterPlayerScripts.LocalScript2
 
    local script1signal = script1.Changed
    local script2signal = script2.Changed
 
    for i, connection in next, getconnections(script1signal) do
        connection:Disable()
    end
    for i, connection in next, getconnections(script2signal) do
        connection:Disable()
    end
 
    script1:Destroy()
    script2:Destroy()

    lib:Notification("Alert.", "Loaded. Successfully Bypassed AC.", "Close")

    maintab:Slider('WalkSpeed', 16, 100, 16, function(value1)    
        
        game:GetService("ReplicatedStorage").globalSpeed.Value = value1
    
    end)
    
    maintab:Slider('JumpPower', 50, 200, 50, function(value2)
    
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value2
    
    end)
    
    maintab:Slider('Field of View', 70, 120, 70, function(amount)
        
        game:GetService'Workspace'.Camera.FieldOfView = amount
    
    end)

    maintab:Toggle('NoClip', false, function(value)
    
        getgenv().nokiz = value
        if getgenv().nokiz == true then

            _G.Noclips = true

            game:GetService("RunService").Stepped:Connect(function()
                if _G.Noclips then
                    pcall(function()
                        game.Players.LocalPlayer.Character:FindFirstChild("Head").CanCollide = false
                        game.Players.LocalPlayer.Character:FindFirstChild("Torso").CanCollide = false
                    end)
                end
            end)

        else if getgenv().nokiz == false then
            _G.Noclips = false
            
            end
        end
    end)
    
    maintab:Toggle('Infinite Jump', false, function(value)

        getgenv().infjumper = value
        
        if getgenv().infjumper == true then
            
            _G.infinjump = true
            
            local Player = game:GetService("Players").LocalPlayer
            local Mouse = Player:GetMouse()
            Mouse.KeyDown:connect(function(k)
                if _G.infinjump then
                    if k:byte() == 32 then
                        Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        Humanoid:ChangeState("Jumping")
                    end
                end
            end)
    
            else if getgenv().infjumper == false then
                    
                _G.infinjump = false
                
            end
        end
    
    end)
    
    maintab:Toggle('Fly', false, function(value, args)
    
        getgenv().flyerwow = value

        if getgenv().flyerwow == true then
            
            NOFLY()
            wait()
            sFLY()
            if args[1] and isNumber(args[1]) then
                iyflyspeed = args[1]
            end
            
            else if getgenv().flyerwow == false then
                NOFLY()
                
            end
        end
    
    end)
    
    maintab:Textbox('Fly Speed', false, function(value)

		iyflyspeed = value
    
    end)

    utiltab:Toggle('God Mode', false, function(value)
    
        godModeThing = value


        if godModeThing == true then


            _G.godMode1 = true
            while _G.godMode1 == true do
                wait()
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.Name == "hitbox" then
                        v.Parent = game.Storage
                        wait()
                    end
                end
            end


        else if godModeThing == false then

            _G.godMode1 = false
            while _G.godMode1 == true do
                wait()
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.Name == "hitbox" then
                        v.Parent = game.Storage
                        wait()
                    end
                end
            end


            for i,v in pairs(game.Storage:GetChildren()) do
                if v.Name == "hitbox" then
                    v.Parent = game.Players.LocalPlayer.Character
                    wait()
                end
            end
        
        end
    end

    end)

    utiltab:Toggle("Anti Negative", false, function(value)
    
        antiNegative = value

        if antiNegative == true then

            local v1 = game:GetService("TweenService"):Create(game.Lighting.Negative, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Saturation = 0
                });
                v1.Completed:Connect(function()
                    game.Lighting.Negative.Enabled = false;
                end);
                v1:Play();


        else if antiNegative == false then

            warn("off lol")

        end
    end

    end)

    utiltab:Toggle("Anti Gravity", false, function(value)
    
        antiGravity = value

        if antiGravity == true then

            _G.antiGrav = true
            while _G.antiGrav == true do
                wait()
                game.Workspace.Gravity = 196.2
            end

        else if antiGravity == false then

            _G.antiGrav = false
            while _G.antiGrav == true do
                wait()
                game.Workspace.Gravity = 196.2
            end

            game.Workspace.Gravity = 196.2

        end
    end

    end)

    utiltab:Toggle("Anti Bunny", false, function(value)
    
        antiBunny = value

        if antiBunny == true then

            _G.antiBun = true
            while _G.antiBun == true do
                wait()
                game.ReplicatedStorage.bunnyJumping.Value = false
            end

        else if antiBunny == false then

            _G.antiBun = false
            while _G.antiBun == true do
                wait()
                game.ReplicatedStorage.bunnyJumping.Value = false
            end

            game.ReplicatedStorage.bunnyJumping.Value = false
            

        end
    end

    end)

    utiltab:Toggle("Anti Fog", false, function(value)
    
        antiFog = value

        if antiFog == true then

            _G.antiFogger = true
            while _G.antiFogger == true do
                wait()
                game.Lighting.FogEnd = 1200
            end

        else if antiFog == false then

            _G.antiFogger = false
            while _G.antiFogger == true do
                wait()
                game.Lighting.FogEnd = 1200
            end

            game.Lighting.FogEnd = 1200
            

        end
    end

    end)

    utiltab:Button("Grab Gear", function()
    
        for _,e in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
            if e:IsA("Tool") then
            e:Destroy()
            end
            end
            wait() 
            for _,v in pairs(game.ReplicatedStorage.Gear:GetDescendants()) do
            if v:IsA("Tool") then
            local CloneThings = v:Clone()
            wait()
            CloneThings.Parent = game.Players.LocalPlayer.Backpack
     
            end
            end    

    end)

    utiltab:Button("Teleport to Top", function()
    
        local endzone = game.Workspace.tower.sections.finish.FinishGlow.CFrame
 
        local player = game.Players.LocalPlayer.Character
        player.HumanoidRootPart.CFrame = endzone

    end)

    utiltab:Button('Rejoin Server', function()
    
        local ts = game:GetService("TeleportService")
    
        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)

    utiltab:Button('Server Hop', function()
    
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
    		if v.playing ~= v.maxPlayers then
    			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
    		end
    	end


    end)

    uitab:Colorpicker("Change UI Color",Color3.fromRGB(93, 143, 194), function(t)
        lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
    end)
    
    credstab:Label('Owner/Founder: Grant1ed#4919')
        credstab:Label('Lead Developer/Scripter: Ducky#3566')
        
    credstab:Button("Copy Discord Invite", function()
            
        setclipboard("https://discord.gg/t2wWA3hph3")
        lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
        
    end)

end

end
