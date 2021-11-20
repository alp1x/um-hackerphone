local QBCore = exports['qb-core']:GetCoreObject()
local UMHackerPhoneStatus = false

RegisterNetEvent("um-hackerphone:client:openphone",function()
    SetNuiFocusKeepInput(true)
    SetNuiFocus(true,true)
    SendNUIMessage({UMHackerPhoneNui = 'open'})
    UMHackerPhoneStatus = true
    TriggerEvent('animations:client:EmoteCommandStart', {"phone"})
end)

CreateThread(function()
    while true do
        local sleep = 500 
        if UMHackerPhoneStatus then
        sleep = 5 
        DisableControlAction(0, 24, true) 
        DisableControlAction(0, 257, true) 
        end
        Wait(sleep)
    end
end)


RegisterNUICallback('um-hackerphone:nuicallback:blackout', function()
    TriggerServerEvent('qb-weathersync:server:toggleBlackout')
end)

RegisterNUICallback("um-hackerphone:nuicallback:targetinformation", function()
    TriggerServerEvent('um-hackerphone:server:targetinformation')
end)


RegisterNetEvent("um-hackerphone:client:targetinfornui", function(targetinfo)
    SendNUIMessage({UMHackerPhoneTargetNui = 'open',targetinformation = targetinfo})
end)


RegisterNUICallback('um-hackerphone:nuicallback:vehiclehealth', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 20 then
        AddExplosion(vehpos.x, vehpos.y, vehpos.z, 5, 50.0, true, false, true)
        else
           TriggerEvent('um-hackerphone:client:notify')
	end
    end
end)


RegisterNetEvent("um-hackerphone:client:notify", function()
    SendNUIMessage({UMHackerPhoneNotifyNui = 'open'})
end)

RegisterNUICallback("um-hackerphone:nuicallback:escape", function()
    SetNuiFocus(false)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    UMHackerPhoneStatus = false
end)

