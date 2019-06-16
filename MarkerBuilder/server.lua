RegisterServerEvent("MarkerBuilder:save")
AddEventHandler("MarkerBuilder:save", function(data)
    local file = LoadResourceFile("MarkerBuilder", "Markers.lua")
    if file then
        string = data.txt .. " | " .. math.round(data.pos.x, 3) ..", ".. math.round(data.pos.y, 3)..", ".. math.round(data.pos.z, 3).." | \n" .. data.txt .. " | {x = " .. math.round(data.pos.x, 3) ..", y = ".. math.round(data.pos.y, 3)..", z = ".. math.round(data.pos.z, 3).."} | \n" .. data.txt .. " | DrawMarker(".. data.type..", "..math.round(data.pos.x, 3) ..", ".. math.round(data.pos.y, 3)..", ".. math.round(data.pos.z, 3) ..", ".. data.dir.x ..", ".. data.dir.y ..", ".. data.dir.z ..", ".. data.rot.x ..", ".. data.rot.y ..", ".. data.rot.z ..", ".. data.scale.x ..", ".. data.scale.y ..", ".. data.scale.z ..", ".. data.color.r ..", ".. data.color.g ..", ".. data.color.b ..", ".. data.color.a ..", ".. data.bobUpAndDown ..", ".. data.faceCamera ..", 2, nil, nil, ".. data.drawOnEnts..") |\n"
        SaveResourceFile("MarkerBuilder", "Markers.lua", file .. string .. "\n", -1)
    return
    end
end)

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end