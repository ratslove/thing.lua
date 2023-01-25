if game.PlaceId == 155615604 then
    local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()

    game.Players.LocalPlayer.PlayerGui.Home.fadeFrame:Destroy()
    
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
            
            lib:Notification('Alert', 'Please Reset to take into effect.', 'Close')
            
            local A_1 = game.Players.LocalPlayer.PlayerGui.Home.hud["StaminaFrame"]
            A_1.Parent = game.Storage
            
            
            else if stamina_thing == false then
                
                lib:Notification('Alert', 'Please Reset to take into effect.', 'Close')
                
                local A_2 = game.Storage["StaminaFrame"]
                A_2.Parent = game.Players.LocalPlayer.PlayerGui.Home.hud
                
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

teletab:Button('Cell Room', function()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(915.473694, 99.9899826, 2441.63013)

    lib:Notification("Success", "Teleported to Cell Room!", "Close") -- (header, text, closebutton) --

end)

teletab:Button('Cafeteria', function()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(934.99176, 99.9899368, 2319.52734)

    lib:Notification("Success", "Teleported to Cafeteria!", "Close") -- (header, text, closebutton) --

end)

teletab:Button('Prison Courtyard', function()
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(842.399109, 97.9999237, 2410.09033)

    lib:Notification("Success", "Teleported to Prison Courtyard!", "Close") -- (header, text, closebutton) --

end)

teletab:Button('Prison Garage', function()
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(582.738281, 98.039917, 2482.43945)

    lib:Notification("Success", "Teleported to Prison Garage!", "Close") -- (header, text, closebutton) --

end)

teletab:Button('Prison Gate', function()
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(504.72467, 117.711334, 2253.07471)

    lib:Notification("Success", "Teleported to Prison Gate!", "Close") -- (header, text, closebutton) --

end)

teletab:Button('Criminal Base', function()
    
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-943, 96, 2055)

    lib:Notification("Success", "Teleported to Criminal Base!", "Close") -- (header, text, closebutton) --

end)

teletab:Button('Guard Spawn', function()

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(802,99,2270)

    lib:Notification("Success", "Teleported to Guard Spawn!", "Close") -- (header, text, closebutton) --

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

gametab:Button('Grab All Coins', function()

    lib:Notification("Notification", "Success. Server Hopping...", "Close")
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Upscalefanatic3/Guesty-Coin-Farm/main/Guesty%20Coin%20Farmer", true))()

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

end

([[This file was protected with MoonSec V3 by Federal#9999]]):gsub('.+', (function(a) _HjEiPznMYBXq = a; end)); return(function(o,...)local k;local s;local t;local l;local r;local f;local e=24915;local n=0;local d={};while n<241 do n=n+1;while n<0x2ca and e%0x22d4<0x116a do n=n+1 e=(e-184)%7780 local u=n+e if(e%0xf00)<0x780 then e=(e+0x2d5)%0x8cd while n<0x2ce and e%0xcd2<0x669 do n=n+1 e=(e-280)%42139 local t=n+e if(e%0x2090)>0x1048 then e=(e*0x2e4)%0xbcb2 local e=40100 if not d[e]then d[e]=0x1 l=(not l)and _ENV or l;end elseif e%2~=0 then e=(e*0xaf)%0x6df2 local e=82246 if not d[e]then d[e]=0x1 l=getfenv and getfenv();end else e=(e+0x1b2)%0x5ae9 n=n+1 local e=5985 if not d[e]then d[e]=0x1 r={};end end end elseif e%2~=0 then e=(e*0x9b)%0x503c while n<0xf3 and e%0x348a<0x1a45 do n=n+1 e=(e+487)%28411 local l=n+e if(e%0x31b6)>0x18db then e=(e*0x30)%0x9aed local e=59572 if not d[e]then d[e]=0x1 f=string;end elseif e%2~=0 then e=(e+0x15a)%0x625e local e=33300 if not d[e]then d[e]=0x1 s="\4\8\116\111\110\117\109\98\101\114\85\75\120\110\105\98\69\121\0\6\115\116\114\105\110\103\4\99\104\97\114\87\100\79\76\108\71\113\69\0\6\115\116\114\105\110\103\3\115\117\98\70\113\75\110\87\79\116\110\0\6\115\116\114\105\110\103\4\98\121\116\101\68\83\68\95\104\79\79\116\0\5\116\97\98\108\101\6\99\111\110\99\97\116\105\88\114\82\113\116\86\100\0\5\116\97\98\108\101\6\105\110\115\101\114\116\80\85\103\74\105\74\109\100\5";end else e=(e-0x36)%0x8230 n=n+1 local e=76918 if not d[e]then d[e]=0x1 k=tonumber;end end end else e=(e-0x231)%0x9094 n=n+1 while n<0x121 and e%0x14bc<0xa5e do n=n+1 e=(e+568)%14938 local s=n+e if(e%0xaec)<0x576 then e=(e-0x22d)%0x72f local e=87191 if not d[e]then d[e]=0x1 t=function(t)local e=0x01 local function d(n)e=e+n return t:sub(e-n,e-0x01)end while true do local n=d(0x01)if(n=="\5")then break end local e=f.byte(d(0x01))local e=d(e)if n=="\2"then e=r.UKxnibEy(e)elseif n=="\3"then e=e~="\0"elseif n=="\6"then l[e]=function(n,e)return o(8,nil,o,e,n)end elseif n=="\4"then e=l[e]elseif n=="\0"then e=l[e][d(f.byte(d(0x01)))];end local n=d(0x08)r[n]=e end end end elseif e%2~=0 then e=(e*0x2d8)%0x2780 local e=26230 if not d[e]then d[e]=0x1 end else e=(e-0x7d)%0xdda n=n+1 local e=46549 if not d[e]then d[e]=0x1 end end end end end e=(e+934)%42252 end t(s);local e={};for n=0x0,0xff do local d=r.WdOLlGqE(n);e[n]=d;e[d]=n;end local function u(n)return e[n];end local d=(function(o,t)local s,d=0x01,0x10 local n={{},{},{}}local l=-0x01 local e=0x01 local f=o while true do n[0x03][r.FqKnWOtn(t,e,(function()e=s+e return e-0x01 end)())]=(function()l=l+0x01 return l end)()if l==(0x0f)then l=""d=0x000 break end end local l=#t while e<l+0x01 do n[0x02][d]=r.FqKnWOtn(t,e,(function()e=s+e return e-0x01 end)())d=d+0x01 if d%0x02==0x00 then d=0x00 r.PUgJiJmd(n[0x01],(u((((n[0x03][n[0x02][0x00]]or 0x00)*0x10)+(n[0x03][n[0x02][0x01]]or 0x00)+f)%0x100)));f=o+f;end end return r.iXrRqtVd(n[0x01])end);t(d(60,"7l0+p2TzxK(YqcbnqK"));t(d(15,"r0YKN!/DL5HdhAG440GLN/KLYD?4g!G4DAhGAid5HALNLNLH!D/DNh0dY5dHHhoLGhAdADhLH!5!L!Lh!N/LKDN/A/hdYD0HgY4LG4hGAK5dd0LLDLL0D54NGdN5KdYH0Y-L4YL0AHd4hKHK55LHL!/L!hNL0HKL4HHH5445AGGYhD!!HA5/LLLhD!KL!:!M0GYY0KGG4ALYDdAKd/d/HbL5L5/D/dN5KdK/Ya40-LA&AGhNhH5GdLKLYh/h/h!d!AN5KAG4t/GLA!AHhNdL5h55K5YHLG/5/Y!GYYNT44VLGHG84KA!/!!!DGHNLMDHD//_!NNdYGhYdD0N.+4!GDA/dGdN5GD0LKD!DNK4!0NL<YdiH/}/GNA/A0ddNAHA5DLH/h!4!LNDN_0HY5454DAhhA/H!AdAHD5HDh/4/LNAN5NYY>YL4YALhHDH/hhLddHK555<!NN!!hN!YNKH0AR555LhGHhAh!H45GH2LN/LNDKDNHYHYH4DH!5H4NA5AAhY!OHY55LADGDY!GNhKGYDtG0DgDA5DG"));local e=(-13122+(function()local d,n=0,1;(function(e)e(e(e))end)(function(e)if d>153 then return e end d=d+1 n=(n*271)%31742 if(n%364)>182 then n=(n+1005)%16007 return e else return e(e(e)and e(e and e))end return e(e(e))end)return n;end)())local ee=(getfenv)or(function()return _ENV end);local h=r._jr_vODE or r.iqZxWdXX;local t=3;local s=4;local l=2;local ne=1;local function g(b,...)local u=d(e,"#uWfCkx15Y& s!ZiWZ+5)subuku5usWDqCW1W Yi1kf&f!CSC5C5Cskes5!ussskxCxsxs1-1CZ&ZkZfZs55 1YTYCY5!5ZV! ! !!ZfZkZ&iCi_iCiZOf(x.1aYuuuuu5uZW&urftf5fffCf fZCWCWCCCsC!k5k5xuxkxWxkx!xi115WC5k1kGkCk5s<sk!1s !Z!YZCZsZkZiiW55&kY8YCY5Z Auu1uuui!GisW!uZZSiuZ5uuC5fYf kukCC!k1k&uQCHx1xf6y/5v5}su(xW1Y5Y5kWCWsWsfefC&xY!&!&YC5kxk4kCk5&fsk!5  !uZWZ&Zu!iZk5C5i5sYJYC*&,uuuuYD!uiWC C s ssosCu5u WfW5!5ZuZ8ZCZ5xOkYx5xCxu07_iz5esu_ks5sYEYn115!YZ&xY!Y &uCbk1C5CskJ&x &!C&u!WsY!5ZYZ5Zu!iif!1Z!iZVxi!i :u&6 s&5&s N!CWvu!ffZCW!CCfkf1C!kyCkC5y5f kux1xuxiW.Cs1!xZfZuCWfusW4WC1iYuYWYs&1& & &fY!YZYskCxuksx4xC& !5!Y!YZxiR&bs!ss5sYsYCY5YsZfufuxWLukWWWsZYuCf!f5fu!H!5!5!sZ_Wxk1kHxYiCTfish6cCCi1u5Ck15C5k5kYWYs1kYCfCfZfsCJCCYk usC ss1s,xIx&x5xs1R!!ZxZ5ZYiWZ!5sYxYCY5Ys7xH!-!u5uCW1 5sfsdsCs5WifiCWCsCuCZk5Z5iuihiCi51Wxu1M1!1uuAW!u5usW(1uY1Y YZ51Y!YiYiY1 s Z YsW isi&5s!ss!E!kZW Yi/iCix55YuYlYCY5ii=iu8u1uZ b i 5 ssouNf1WifuC%W5C5Cuk!C!kZiXi&i5isr4xY1kxZ1k155 usWCWCW5WsY1Yk&k&uC6kCC5CskX ks5sssss!s s!ZC!!Z1Z&&iZZi i iZYC&CYs&H&Ci&u uWWeW1fCZIuYf fuCWiC!5ZYZGZCZ5C f5kZf!xkkQ1Z1xkYxYkx1r5!WaWsW5Wsf2&5&1&& k u&& usWkCkiksx;xC N!u!u!5!!ZZif5C i5sYOYCZsSCDYu1s5uWuYW%u!!sf1Wkf ZsCzCxC1k}CkC1kskukCuCxixk1CxsW5kY1i5f5xxi5k51C55WxfkCY& kxN5&&! v ksx Ys55fY!&u&k&Y1C5W1s5Q5C!W!i!iZW!!S&<fuf_suu c   5 ss2uCfCW!CYfYC&CiZIZ1Z5Zsi8CYx&x56nH1{5(suR51Yu5&WnY!W5WsfRYs&s 0 M 15W1 1i 5susisf!f!&!)YZ!1Z1ZY&iZki5ik iN i!iZa5ufu1u1WfZfZYZsixi&IPQ/K1c&I!u^uku!uiWCWYWCW5fWfYff1Y1i5kx&5Ek!x&1WYkxfxk5fY!5C&u&Ysu uYisZ Z!u!fsk!x&usxZxsis5ikssZZsWZYixnuZZ* uZiYW.)ii5AZuCW5iYW1W!f&W f uCW f!fskfffxuC&Wi1Tx15u1x1fxku5k&WMWCW5WsfkfCf5fsCuCCC5CsxWx!k5ksx=1ix5xs1)5x5u1s5T5C&&5sY9YC Z&i&z&C&5 W 9 k 5Zus<s5Zuss!T!C!Z!sZuZCZs8ki}iCi56flt%kS56sW5uCu5usWuWCW5WsCWf5f5fsC0xfC5Csk41Cxxksx<xCx5xs1&1C5&Yk595x55Y&YLYCY5Ys >&C&5&s W C & s!Ws s5ss!/ZW!5!sZNix;fZsiciCWWisA0BCu&uuu.uCu5W!W;WCW5fZfCfCf5fsxYCCC5Cs1/xik5ksx<xCx5111?1CY!1s5u5C555sYCYC&&Yi&r&x&5 ! * C 5ss!YsCsYssi5!C!&!subZ1Z5Z!iF:&i5n5H.MCXshsuWuCu5usWuWCk5fuflfxf5CiCGxCC5ksk1kCkYks5CxCx&xs5W15151Z5XYW555sY^ C CYs&W&C&&&s!x C 5sYs(s5s5ss!.!x!5+sZ ZCZsZsMYiCi!isctu!>5uuu3uku5usW+WCfWWsfxfCf5fsCkCC15kkk9k&k5xYx:x x51Z5&1C1i1s&u5C555s&WY5Y5&C&Usf&5&s <!C!i ss5sC!%ssi1!Ci5ZYZeZsZ5iCi}uui5usgfaCuTDsu5uCW?usfWf!W5fkfMCCf5fsCECCxkCsk1kCkiksxYxC151C161&155W5J5 55 s&kYCYZYs&f&C&s&ssW 5 5sfsJZ1s5ss!GZx!Z!sZ5ZCZYZsioiCi5u1eE^ +5;Zujuxu5WsffWCWZWsCsfCfifsC-C&C5kfk;kkk5ksxpxC58xs151C151s5f5C 5YWYDYsY5&k&J x&5 Z ! Csu s!isCs5ssij!i!5ZkZ_Z!Z5ixiFIxuWis0 >Cu1AsutuCu5fxWHW!W5f1f^fxf5ksk&CCkuCskYkCx!ksx;1Cx51k1<1x151Z5qYCYu5sY5YC WYs&Y&C!5 1 4 s 5!fs2sxs5ss!C!C!i!sZ5ZCZYZs9KM&i5eW/DusM5ufu}uCfkusWkWCWZWsfufCC5kWCvC5C5x&kvkYk5ks1fxCx&xs1C1C1&1sYoYi555!YI&5Y5YZ&B&C& &s > C & ssWsCs5Z1!e!C!5!!ZBZCZ5ZsitiCi5");local n=0;r.XWVlCfDb(function()r.GtBZKPrc()n=n+1 end)local function e(e,d)if d then return n end;n=e+n;end local d,n,a=o(0,o,e,u,r.DSD_hOOt);local function f()local d,n=r.DSD_hOOt(u,e(1,3),e(5,6)+2);e(2);return(n*256)+d;end;local c=true;local c=0 local function z()local e=n();local n=n();local t=1;local l=(d(n,1,20)*(2^32))+e;local e=d(n,21,31);local n=((-1)^d(n,32));if(e==0)then if(l==c)then return n*0;else e=1;t=0;end;elseif(e==2047)then return(l==0)and(n*(1/0))or(n*(0/0));end;return r.BixUhhRp(n,e-1023)*(t+(l/(2^52)));end;local p=n;local function _(n)local d;if(not n)then n=p();if(n==0)then return'';end;end;d=r.FqKnWOtn(u,e(1,3),e(5,6)+n-1);e(n)local e=""for n=(1+c),#d do e=e..r.FqKnWOtn(d,n,n)end return e;end;local y=#r.IjkyStzC(k('\49.\48'))~=1 local e=n;local function p(...)return{...},r.gZHGiXgC('#',...)end local function g()local e={};local h={};local k={};local c={h,k,nil,e};local e=n()local u={}for l=1,e do local d=a();local n;if(d==2)then n=(a()~=#{});elseif(d==1)then local e=z();if y and r.hrdgbCpA(r.IjkyStzC(e),'.(\48+)$')then e=r.mjkcYqpQ(e);end n=e;elseif(d==0)then n=_();end;u[l]=n;end;c[3]=a();for k=1,n()do local e=a();if(d(e,1,1)==0)then local o=d(e,2,3);local r=d(e,4,6);local e={f(),f(),nil,nil};if(o==0)then e[t]=f();e[s]=f();elseif(o==#{1})then e[t]=n();elseif(o==b[2])then e[t]=n()-(2^16)elseif(o==b[3])then e[t]=n()-(2^16)e[s]=f();end;if(d(r,1,1)==1)then e[l]=u[e[l]]end if(d(r,2,2)==1)then e[t]=u[e[t]]end if(d(r,3,3)==1)then e[s]=u[e[s]]end h[k]=e;end end;for e=1,n()do k[e-(#{1})]=g();end;return c;end;local function m(d,n,e)local l=n;local l=e;return k(r.hrdgbCpA(r.hrdgbCpA(({r.XWVlCfDb(d)})[2],n),e))end local function j(k,e,u)local function j(...)local f,j,a,y,z,n,m,g,b,c,_,d;local e=0;while-1<e do if 3<=e then if 4<e then if e>3 then for n=45,69 do if e>5 then e=-2;break;end;d=o(7);break;end;else e=-2;end else if e>=-1 then repeat if 4>e then g={};b={...};break;end;c=r.gZHGiXgC('#',...)-1;_={};until true;else c=r.gZHGiXgC('#',...)-1;_={};end end else if 0>=e then f=o(6,9,1,45,k);j=o(6,1,2,30,k);else if 0<e then repeat if e<2 then a=o(6,54,3,27,k);z=p y=0;break;end;n=-41;m=-1;until true;else a=o(6,54,3,27,k);z=p y=0;end end end e=e+1;end;for e=0,c do if(e>=a)then g[e-a]=b[e+1];else d[e]=b[e+1];end;end;local e=c-a+1 local e;local o;local function a(...)while true do end end while true do if n<-40 then n=n+42 end e=f[n];o=e[ne];if 20>o then if 10<=o then if 15>o then if o>=12 then if 12<o then if o~=13 then local r,b,a,k,p,c,g,o;for o=0,6 do if 2>=o then if o<1 then r=e[l];b=d[e[t]];d[r+1]=b;d[r]=b[e[s]];n=n+1;e=f[n];else if-2<o then repeat if 2>o then d(e[l],e[t]);n=n+1;e=f[n];break;end;r=e[l]d[r]=d[r](h(d,r+1,e[t]))n=n+1;e=f[n];until true;else d(e[l],e[t]);n=n+1;e=f[n];end end else if o<=4 then if o~=-1 then repeat if o~=4 then u[e[t]]=d[e[l]];n=n+1;e=f[n];break;end;o=0;while o>-1 do if 3>o then if 1>o then a=e;else if-2<o then for e=31,82 do if 1<o then p=t;break;end;k=l;break;end;else k=l;end end else if 4<o then if 3<=o then for e=23,81 do if 5<o then o=-2;break;end;d(g,c);break;end;else o=-2;end else if o>=1 then for e=44,93 do if 3<o then g=a[k];break;end;c=a[p];break;end;else c=a[p];end end end o=o+1 end n=n+1;e=f[n];until true;else u[e[t]]=d[e[l]];n=n+1;e=f[n];end else if o>1 then for s=28,83 do if 5~=o then d[e[l]]=u[e[t]];break;end;u[e[t]]=d[e[l]];n=n+1;e=f[n];break;end;else u[e[t]]=d[e[l]];n=n+1;e=f[n];end end end end else local f,o,u,r,s;local n=0;while n>-1 do if 2>=n then if n>0 then if 1==n then o=l;else u=t;end else f=e;end else if n>4 then if n>1 then for e=21,56 do if 6~=n then d(s,r);break;end;n=-2;break;end;else d(s,r);end else if 2<=n then for e=12,77 do if n>3 then s=f[o];break;end;r=f[u];break;end;else s=f[o];end end end n=n+1 end end else if(d[e[l]]==e[s])then n=n+1;else n=e[t];end;end else if 11==o then local n=e[l];local l=d[e[t]];d[n+1]=l;d[n]=l[e[s]];else u[e[t]]=d[e[l]];end end else if 16>=o then if o>12 then for n=26,83 do if 15~=o then d[e[l]][e[t]]=d[e[s]];break;end;local a,h,k,o,u,r,f;local n=0;while n>-1 do if n<3 then if n>=1 then if n>=-1 then repeat if n~=2 then o=e;break;end;u=o[h];until true;else o=e;end else a=l;h=t;k=s;end else if 5>n then if n>3 then f=d[u];for e=1+u,o[k]do f=f..d[e];end;else r=o[a];end else if n>2 then repeat if 5<n then n=-2;break;end;d[r]=f;until true;else d[r]=f;end end end n=n+1 end break;end;else local a,h,k,o,u,r,f;local n=0;while n>-1 do if n<3 then if n>=1 then if n>=-1 then repeat if n~=2 then o=e;break;end;u=o[h];until true;else o=e;end else a=l;h=t;k=s;end else if 5>n then if n>3 then f=d[u];for e=1+u,o[k]do f=f..d[e];end;else r=o[a];end else if n>2 then repeat if 5<n then n=-2;break;end;d[r]=f;until true;else d[r]=f;end end end n=n+1 end end else if o<18 then local s,r,f,o,u;local n=0;while n>-1 do if n<3 then if n<=0 then s=e;else if-1~=n then repeat if 1<n then f=t;break;end;r=l;until true;else f=t;end end else if 5<=n then if n~=3 then for e=45,54 do if n~=5 then n=-2;break;end;d(u,o);break;end;else n=-2;end else if n~=-1 then repeat if n~=4 then o=s[f];break;end;u=s[r];until true;else o=s[f];end end end n=n+1 end else if o>=16 then for r=19,83 do if 18~=o then local o;o=e[l]d[o]=d[o](h(d,o+1,e[t]))n=n+1;e=f[n];d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];o=e[l]d[o]=d[o](d[o+1])n=n+1;e=f[n];do return end;break;end;local n=e[l]d[n]=d[n](h(d,n+1,e[t]))break;end;else local o;o=e[l]d[o]=d[o](h(d,o+1,e[t]))n=n+1;e=f[n];d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];o=e[l]d[o]=d[o](d[o+1])n=n+1;e=f[n];do return end;end end end end else if 4<o then if o>6 then if 7<o then if 4<=o then repeat if 9>o then local n=e[l];local l=d[n];for e=n+1,e[t]do r.PUgJiJmd(l,d[e])end;break;end;local e=e[l]d[e]=d[e](d[e+1])until true;else local e=e[l]d[e]=d[e](d[e+1])end else d[e[l]]={};end else if o~=4 then repeat if o>5 then local r,a,b,c,h,o,k;for o=0,6 do if 3>o then if 0>=o then o=0;while o>-1 do if 3<=o then if 4<o then if 4~=o then repeat if 5~=o then o=-2;break;end;d(h,c);until true;else d(h,c);end else if-1~=o then repeat if 3~=o then h=r[a];break;end;c=r[b];until true;else h=r[a];end end else if o>=1 then if-3~=o then for e=21,65 do if 2~=o then a=l;break;end;b=t;break;end;else a=l;end else r=e;end end o=o+1 end n=n+1;e=f[n];else if 0~=o then repeat if 2~=o then k=e[l]d[k]=d[k](d[k+1])n=n+1;e=f[n];break;end;d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];until true;else d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];end end else if o<=4 then if o~=0 then for t=14,83 do if o~=3 then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]]={};n=n+1;e=f[n];break;end;else d[e[l]]={};n=n+1;e=f[n];end else if 6~=o then d[e[l]][e[t]]=e[s];n=n+1;e=f[n];else d[e[l]]=u[e[t]];end end end end break;end;for o=0,3 do if o<=1 then if o==0 then d[e[l]]=(e[t]~=0);n=n+1;e=f[n];else u[e[t]]=d[e[l]];n=n+1;e=f[n];end else if o>2 then if(d[e[l]]==e[s])then n=n+1;else n=e[t];end;else d[e[l]]=u[e[t]];n=n+1;e=f[n];end end end until true;else local r,k,b,c,a,o,h;for o=0,6 do if 3>o then if 0>=o then o=0;while o>-1 do if 3<=o then if 4<o then if 4~=o then repeat if 5~=o then o=-2;break;end;d(a,c);until true;else d(a,c);end else if-1~=o then repeat if 3~=o then a=r[k];break;end;c=r[b];until true;else a=r[k];end end else if o>=1 then if-3~=o then for e=21,65 do if 2~=o then k=l;break;end;b=t;break;end;else k=l;end else r=e;end end o=o+1 end n=n+1;e=f[n];else if 0~=o then repeat if 2~=o then h=e[l]d[h]=d[h](d[h+1])n=n+1;e=f[n];break;end;d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];until true;else d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];end end else if o<=4 then if o~=0 then for t=14,83 do if o~=3 then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]]={};n=n+1;e=f[n];break;end;else d[e[l]]={};n=n+1;e=f[n];end else if 6~=o then d[e[l]][e[t]]=e[s];n=n+1;e=f[n];else d[e[l]]=u[e[t]];end end end end end end else if 1>=o then if-1<=o then for n=21,59 do if 0~=o then d[e[l]][e[t]]=e[s];break;end;local l=e[l];local n=d[e[t]];d[l+1]=n;d[l]=n[e[s]];break;end;else d[e[l]][e[t]]=e[s];end else if o<=2 then d[e[l]][e[t]]=e[s];else if 0~=o then repeat if 4>o then d[e[l]]=(e[t]~=0);break;end;d[e[l]]=u[e[t]];until true;else d[e[l]]=(e[t]~=0);end end end end end else if o<30 then if 25<=o then if 26<o then if 27>=o then d[e[l]]=d[e[t]][e[s]];else if o>=24 then repeat if o~=29 then local u,r;for o=0,6 do if o>=3 then if o<=4 then if o~=-1 then for t=11,53 do if 3<o then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]]={};n=n+1;e=f[n];break;end;else d[e[l]]={};n=n+1;e=f[n];end else if 2<o then repeat if 5<o then d(e[l],e[t]);break;end;d[e[l]][e[t]]=e[s];n=n+1;e=f[n];until true;else d[e[l]][e[t]]=e[s];n=n+1;e=f[n];end end else if 1<=o then if-3~=o then for r=16,85 do if 2~=o then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]][e[t]]=e[s];n=n+1;e=f[n];break;end;else d[e[l]][e[t]]=e[s];n=n+1;e=f[n];end else u=e[l];r=d[e[t]];d[u+1]=r;d[u]=r[e[s]];n=n+1;e=f[n];end end end break;end;local n=e[l];local l=d[n];for e=n+1,e[t]do r.PUgJiJmd(l,d[e])end;until true;else local u,r;for o=0,6 do if o>=3 then if o<=4 then if o~=-1 then for t=11,53 do if 3<o then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]]={};n=n+1;e=f[n];break;end;else d[e[l]]={};n=n+1;e=f[n];end else if 2<o then repeat if 5<o then d(e[l],e[t]);break;end;d[e[l]][e[t]]=e[s];n=n+1;e=f[n];until true;else d[e[l]][e[t]]=e[s];n=n+1;e=f[n];end end else if 1<=o then if-3~=o then for r=16,85 do if 2~=o then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]][e[t]]=e[s];n=n+1;e=f[n];break;end;else d[e[l]][e[t]]=e[s];n=n+1;e=f[n];end else u=e[l];r=d[e[t]];d[u+1]=r;d[u]=r[e[s]];n=n+1;e=f[n];end end end end end else if o>25 then local o,a,k;for u=0,6 do if u<3 then if u<1 then d(e[l],e[t]);n=n+1;e=f[n];else if u>0 then for r=46,73 do if 2>u then o=e[l]d[o]=d[o](h(d,o+1,e[t]))n=n+1;e=f[n];break;end;o=e[l];a=d[e[t]];d[o+1]=a;d[o]=a[e[s]];n=n+1;e=f[n];break;end;else o=e[l];a=d[e[t]];d[o+1]=a;d[o]=a[e[s]];n=n+1;e=f[n];end end else if u>4 then if u>=3 then for h=38,72 do if u~=5 then o=e[l];k=d[o];for e=o+1,e[t]do r.PUgJiJmd(k,d[e])end;break;end;d[e[l]][e[t]]=e[s];n=n+1;e=f[n];break;end;else d[e[l]][e[t]]=e[s];n=n+1;e=f[n];end else if 3==u then o=e[l]d[o]=d[o](d[o+1])n=n+1;e=f[n];else d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];end end end end else n=e[t];end end else if o<22 then if 17~=o then repeat if 20<o then d[e[l]]={};break;end;local n=e[l]d[n]=d[n](h(d,n+1,e[t]))until true;else d[e[l]]={};end else if o>=23 then if o~=22 then repeat if o~=24 then local e=e[l]d[e]=d[e](d[e+1])break;end;do return end;until true;else do return end;end else d[e[l]][e[t]]=d[e[s]];end end end else if 34>=o then if o<=31 then if 26<o then for f=17,76 do if 31~=o then n=e[t];break;end;if(d[e[l]]==e[s])then n=n+1;else n=e[t];end;break;end;else if(d[e[l]]==e[s])then n=n+1;else n=e[t];end;end else if o<33 then d[e[l]]=u[e[t]];else if o==34 then do return end;else d[e[l]]=d[e[t]][e[s]];end end end else if 37>o then if 36>o then local t=e[t];local n=d[t]for e=t+1,e[s]do n=n..d[e];end;d[e[l]]=n;else d[e[l]]=(e[t]~=0);end else if 37>=o then for o=0,6 do if 2<o then if 5>o then if 2<=o then repeat if o>3 then d[e[l]]={};n=n+1;e=f[n];break;end;d[e[l]][e[t]]=e[s];n=n+1;e=f[n];until true;else d[e[l]][e[t]]=e[s];n=n+1;e=f[n];end else if o<6 then d[e[l]][e[t]]=e[s];n=n+1;e=f[n];else d[e[l]][e[t]]=d[e[s]];end end else if 1<=o then if o~=0 then repeat if 2~=o then d[e[l]]=u[e[t]];n=n+1;e=f[n];break;end;d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];until true;else d[e[l]]=u[e[t]];n=n+1;e=f[n];end else d[e[l]]={};n=n+1;e=f[n];end end end else if 35<=o then repeat if o>38 then local r,o;d[e[l]]=d[e[t]][e[s]];n=n+1;e=f[n];d[e[l]]=d[e[t]][e[s]];n=n+1;e=f[n];d[e[l]]=d[e[t]][e[s]];n=n+1;e=f[n];d(e[l],e[t]);n=n+1;e=f[n];r=e[t];o=d[r]for e=r+1,e[s]do o=o..d[e];end;d[e[l]]=o;n=n+1;e=f[n];d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];d[e[l]][e[t]]=e[s];break;end;u[e[t]]=d[e[l]];until true;else local r,o;d[e[l]]=d[e[t]][e[s]];n=n+1;e=f[n];d[e[l]]=d[e[t]][e[s]];n=n+1;e=f[n];d[e[l]]=d[e[t]][e[s]];n=n+1;e=f[n];d(e[l],e[t]);n=n+1;e=f[n];r=e[t];o=d[r]for e=r+1,e[s]do o=o..d[e];end;d[e[l]]=o;n=n+1;e=f[n];d[e[l]][e[t]]=d[e[s]];n=n+1;e=f[n];d[e[l]][e[t]]=e[s];end end end end end end n=1+n;end;end;return j end;local t=0xff;local u={};local f=(1);local l='';(function(n)local d=n local s=0x00 local e=0x00 d={(function(l)if s>0x27 then return l end s=s+1 e=(e+0xd98-l)%0x12 return(e%0x03==0x2 and(function(d)if not n[d]then e=e+0x01 n[d]=(0xee);end return true end)'eQODw'and d[0x1](0x29f+l))or(e%0x03==0x0 and(function(d)if not n[d]then e=e+0x01 n[d]=(0x70);end return true end)'Sfjpq'and d[0x3](l+0x200))or(e%0x03==0x1 and(function(d)if not n[d]then e=e+0x01 n[d]=(0x94);end return true end)'BCfDC'and d[0x2](l+0x16e))or l end),(function(o)if s>0x2e then return o end s=s+1 e=(e+0x9d8-o)%0x17 return(e%0x03==0x1 and(function(d)if not n[d]then e=e+0x01 n[d]=(0xec);l='\37';t={function()t()end};l=l..'\100\43';end return true end)'qhHcp'and d[0x3](0x1e8+o))or(e%0x03==0x0 and(function(d)if not n[d]then e=e+0x01 n[d]=(0x49);end return true end)'aJFeF'and d[0x2](o+0x1d7))or(e%0x03==0x2 and(function(d)if not n[d]then e=e+0x01 n[d]=(0x61);u[f]=ee();f=f+t;end return true end)'yKCU_'and d[0x1](o+0x3db))or o end),(function(o)if s>0x2e then return o end s=s+1 e=(e+0x1211-o)%0x2f return(e%0x03==0x2 and(function(d)if not n[d]then e=e+0x01 n[d]=(0xb4);l={l..'\58 a',l};u[f]=g();f=f+((not r.VezVuiGd)and 1 or 0);l[1]='\58'..l[1];t[2]=0xff;end return true end)'fvHfI'and d[0x3](0x32a+o))or(e%0x03==0x1 and(function(d)if not n[d]then e=e+0x01 n[d]=(0x2a);t[2]=(t[2]*(m(function()u()end,h(l))-m(t[1],h(l))))+1;u[f]={};t=t[2];f=f+t;end return true end)'HDxoz'and d[0x2](o+0xad))or(e%0x03==0x0 and(function(d)if not n[d]then e=e+0x01 n[d]=(0x83);end return true end)'AkqGa'and d[0x1](o+0x31d))or o end)}d[0x2](0x1254)end){};local e=j(h(u));return e(...);end return g((function()local n={}local e=0x01;local d;if r.VezVuiGd then d=r.VezVuiGd(g)else d=''end if r.hrdgbCpA(d,r.bvMrXWov)then e=e+0;else e=e+1;end n[e]=0x02;n[n[e]+0x01]=0x03;return n;end)(),...)end)((function(d,e,n,t,l,f)local f;if d>=4 then if d<=5 then if 1<d then repeat if d<5 then local d=t;local f,l,s=l(2);do return function()local o,t,n,e=e(n,d(d,d),d(d,d)+3);d(4);return(e*f)+(n*l)+(t*s)+o;end;end;break;end;local d=t;do return function()local e=e(n,d(d,d),d(d,d));d(1);return e;end;end;until true;else local d=t;local t,l,f=l(2);do return function()local e,n,o,s=e(n,d(d,d),d(d,d)+3);d(4);return(s*t)+(o*l)+(n*f)+e;end;end;end else if d>=7 then if 8>d then do return setmetatable({},{['__\99\97\108\108']=function(e,t,l,d,n)if n then return e[n]elseif d then return e else e[t]=l end end})end else do return n(d,nil,n);end end else do return l[n]end;end end else if 2<=d then if d~=1 then for f=37,66 do if d~=2 then do return e(1),e(4,l,t,n,e),e(5,l,t,n)end;break;end;do return 16777216,65536,256 end;break;end;else do return e(1),e(4,l,t,n,e),e(5,l,t,n)end;end else if d~=-2 then for f=20,58 do if d~=0 then do return function(n,e,d)if d then local e=(n/2^(e-1))%2^((d-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(n%(e+e)>=e)and 1 or 0;end;end;end;break;end;do return e(1),e(4,l,t,n,e),e(5,l,t,n)end;break;end;else do return function(d,e,n)if n then local e=(d/2^(e-1))%2^((n-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(d%(e+e)>=e)and 1 or 0;end;end;end;end end end end),...)	
