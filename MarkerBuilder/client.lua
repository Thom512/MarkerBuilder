_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("MarkerBuilder", "~p~Discord : Thom512#0990")
_menuPool:Add(mainMenu)

local Actif = false
local type = 1
local posAdd = {x = 0.0, y = 0.0, z = 0.0}
local dir = {x = 0.0, y = 0.0, z = 0.0}
local rot = {x = 0.0, y = 0.0, z = 0.0}
local scale = {x = 1.0, y = 1.0, z = 1.0}
local color = {r = 255, g = 0, b = 0, a = 255}
local bobUpAndDown = false
local faceCamera = false
local drawOnEnts = false

local coords = {x = 0.0, y = 0.0, z = 0.0}

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function AddMenu(menu)
    local itemMain = NativeUI.CreateCheckboxItem("Actif", Actif, "Active le marker, c'est mieux pour le modifier :)")
	menu:AddItem(itemMain)
    
    local types = {}
    for i = 1, 43 do types[i] = i end
        
    local newitem = NativeUI.CreateListItem("Type", types, 1)
    menu:AddItem(newitem)
    
    AddMenuPosition(menu)
    
    AddMenuRotation(menu)
    
    AddMenuScale(menu)
        
    AddMenuColors(menu)
    
	local itemBobUpAndDown = NativeUI.CreateCheckboxItem("bobUpAndDown", bobUpAndDown, "Animation haut/bas du marker")
	menu:AddItem(itemBobUpAndDown)
    local itemFaceCamera = NativeUI.CreateCheckboxItem("faceCamera", faceCamera, "Marker face à la camera")
    menu:AddItem(itemFaceCamera)
    
    menu.OnCheckboxChange = function(sender, item, checked_)
        if item == itemMain then Actif = checked_ end
        if item == itemBobUpAndDown then bobUpAndDown = checked_ end
		if item == itemFaceCamera then faceCamera = checked_ end
    end
    
    menu.OnListChange = function(sender, item, index)
        if item == newitem then type = item:IndexToItem(index) end
    end
end

function AddMenuPosition(menu)
	local submenu = _menuPool:AddSubMenu(menu, "~b~Position")
	local X = {}
	local Y = {}
	local Z = {}

    
	for i = 1, 100 do X[i] = (i/10)-5.0 end
	local itemX = NativeUI.CreateListItem("Décalage X", X, 50)
    submenu:AddItem(itemX)
    
    for i = 1, 100 do Y[i] = (i/10)-5.0 end
	local itemY = NativeUI.CreateListItem("Décalage Y", Y, 50)
    submenu:AddItem(itemY)
    
    for i = 1, 100 do Z[i] = (i/10)-5.0 end
	local itemZ = NativeUI.CreateListItem("Décalage Z", Z, 50)
    submenu:AddItem(itemZ)
    
    submenu.OnListChange = function(sender, item, index)
        if item == itemX then posAdd.x = item:IndexToItem(index) end
        if item == itemY then posAdd.y = item:IndexToItem(index) end
        if item == itemZ then posAdd.z = item:IndexToItem(index) end
    end
end

function AddMenuRotation(menu)
	local submenu = _menuPool:AddSubMenu(menu, "~b~Rotation")
	local X = {}
	local Y = {}
	local Z = {}

    
	for i = 1, 72 do X[i] = (i*5)-5.0 end
	local itemX = NativeUI.CreateListItem("Rotation X", X, 1, "Rotation en degré")
    submenu:AddItem(itemX)
    
    for i = 1, 72 do Y[i] = (i*5)-5.0 end
	local itemY = NativeUI.CreateListItem("Rotation Y", Y, 1, "Rotation en degré")
    submenu:AddItem(itemY)
    
    for i = 1, 72 do Z[i] = (i*5)-5.0 end
	local itemZ = NativeUI.CreateListItem("Rotation Z", Z, 1, "Rotation en degré")
    submenu:AddItem(itemZ)
    
    submenu.OnListChange = function(sender, item, index)
        if item == itemX then rot.x = item:IndexToItem(index) end
        if item == itemY then rot.y = item:IndexToItem(index) end
        if item == itemZ then rot.z = item:IndexToItem(index) end
    end
end

function AddMenuScale(menu)
	local submenu = _menuPool:AddSubMenu(menu, "~b~Taille")
    local XYZ = {}
	local X = {}
	local Y = {}
	local Z = {}

    for i = 1, 100 do XYZ[i] = i/10 end
	local itemAll = NativeUI.CreateListItem("Taille globale", XYZ, 10, "Taille du marker")
    submenu:AddItem(itemAll)
    
	for i = 1, 100 do X[i] = i/10 end
	local itemX = NativeUI.CreateListItem("Taille X", X, 10)
    submenu:AddItem(itemX)
    
    for i = 1, 72 do Y[i] = i/10 end
	local itemY = NativeUI.CreateListItem("Taille Y", Y, 10)
    submenu:AddItem(itemY)
    
    for i = 1, 72 do Z[i] = i/10 end
	local itemZ = NativeUI.CreateListItem("Taille Z", Z, 10)
    submenu:AddItem(itemZ)
    
    submenu.OnListChange = function(sender, item, index)
        if item == itemX then scale.x = item:IndexToItem(index) end
        if item == itemY then scale.y = item:IndexToItem(index) end
        if item == itemZ then scale.z = item:IndexToItem(index) end
        if item == itemAll then 
            scale.x = item:IndexToItem(index)
            scale.y = item:IndexToItem(index) 
            scale.z = item:IndexToItem(index) 
        end
    end
end

function AddMenuColors(menu)
	local submenu = _menuPool:AddSubMenu(menu, "~y~Couleurs")
	local R = {}
	local G = {}
	local B = {}
	local A = {}
    
	for i = 1, 52 do R[i] = (i * 5)-5 end
	local itemRouge = NativeUI.CreateListItem("~r~Rouge", R, 52)
    submenu:AddItem(itemRouge)
    
    for i = 1, 52 do G[i] = (i * 5)-5 end
	local itemBleu = NativeUI.CreateListItem("~g~Vert", G, 1)
    submenu:AddItem(itemBleu)
    
    for i = 1, 52 do B[i] = (i * 5)-5 end
	local itemVert = NativeUI.CreateListItem("~b~Bleu", B, 1)
    submenu:AddItem(itemVert)
    
    for i = 1, 52 do A[i] = (i * 5)-5 end
	local itemAlpha = NativeUI.CreateListItem("Alpha", A, 52, "Règle la transparence")
    submenu:AddItem(itemAlpha)
    
    submenu.OnListChange = function(sender, item, index)
        if item == itemRouge then color.r = item:IndexToItem(index) end
        if item == itemBleu then color.g = item:IndexToItem(index) end
        if item == itemVert then color.b = item:IndexToItem(index) end
        if item == itemAlpha then color.a = item:IndexToItem(index) end
    end
end

function AddMenuValider(menu)    
	local Item = NativeUI.CreateItem("~g~Enregistrer", "Sauvegarder le marker")
	Item:SetRightBadge(BadgeStyle.Tick)
    menu:AddItem(Item)
	menu.OnItemSelect = function(menu, item)
		if item == Item then
			AddTextEntry('MARKERBUILDER', 'Nom du marker:')
			txt = nil
			DisplayOnscreenKeyboard(1, "MARKERBUILDER", "", "", "", "", "", 20)
			while (UpdateOnscreenKeyboard() == 0) do
				DisableAllControlActions(0)
				Wait(0)
			end
			if (GetOnscreenKeyboardResult()) then
				txt = GetOnscreenKeyboardResult()
                --local ped       = GetPlayerPed(-1)
                --local coords    = GetEntityCoords(ped)
                local x, y, z   = coords.x + posAdd.x, coords.y + posAdd.y, coords.z + posAdd.z 
                local data = {
                    txt = txt, 
                    type = type,
                    pos = {x = x, y = y, z = z},
                    dir = {x = 0.0, y = 0.0, z = 0.0},
                    rot = {x = rot.x, y = rot.y, z = rot.z},
                    scale = {x = scale.x, y = scale.y, z = scale.z},
                    color = {r = color.r, g = color.g, b = color.b, a = color.a},
                    bobUpAndDown = tostring(bobUpAndDown),
                    faceCamera = tostring(faceCamera),
                    drawOnEnts = tostring(drawOnEnts),
                    }
                    
                    --string = data.txt .. " | " .. math.round(data.pos.x, 3) ..", ".. math.round(data.pos.y, 3)..", ".. math.round(data.pos.z, 3).." | \n" .. data.txt .. " | {x = " .. math.round(data.pos.x, 3) ..", y = ".. math.round(data.pos.y, 3)..", z = ".. math.round(data.pos.z, 3).."} | \n" .. data.txt .. " | DrawMarker(".. data.type..", "..math.round(data.pos.x, 3) ..", ".. math.round(data.pos.y, 3)..", ".. math.round(data.pos.z, 3) ..", ".. data.dir.x ..", ".. data.dir.y ..", ".. data.dir.z ..", ".. data.rot.x ..", ".. data.rot.y ..", ".. data.rot.z ..", ".. data.scale.x ..", ".. data.scale.y ..", ".. data.scale.z ..", ".. data.color.r ..", ".. data.color.g ..", ".. data.color.b ..", ".. data.color.a ..", ".. data.bobUpAndDown ..", ".. data.faceCamera ..", 2, nil, nil, ".. data.drawOnEnts..") |\n"                                                                                                                                   
                    --print(string)
                    TriggerServerEvent("MarkerBuilder:save", data)
                    ShowNotification("Marker bien ~g~sauvegardé !")
			end
		end
	end
	
end

function math.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end


AddMenu(mainMenu)
AddMenuValider(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Wait(0)
        _menuPool:ProcessMenus()
        if IsControlJustPressed(1, 70) then
            coords    = GetEntityCoords(GetPlayerPed(-1))
            mainMenu:Visible(not mainMenu:Visible())
			SetCursorLocation(0.5, 0.5)
        end
        if Actif then
            --local ped       = GetPlayerPed(-1)
            --local coords    = GetEntityCoords(ped)
            local x, y, z     = coords.x + posAdd.x, coords.y + posAdd.y, coords.z + posAdd.z 
            DrawMarker(type, x, y, z, dir.x, dir.y, dir.z, rot.x, rot.y, rot.z, scale.x, scale.y, scale.z, color.r, color.g, color.b, color.a, bobUpAndDown, faceCamera, 2, nil, nil, drawOnEnts)            
        end
    end
end)
