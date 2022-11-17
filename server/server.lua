local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("hackerphone", function(source)
   local src = source
   local Player = QBCore.Functions.GetPlayer(src)
   local name = Player.PlayerData.charinfo.firstname
   TriggerClientEvent('um-hackerphone:client:openphone',src,name)
end)

QBCore.Functions.CreateUseableItem("tracker", function(source)
   TriggerClientEvent('um-hackerphone:client:vehicletracker',source)
end)

QBCore.Functions.CreateUseableItem("centralchip", function(source)
   TriggerClientEvent('um-hackerphone:client:centralchip',source)
end)

RegisterNetEvent('um-hackerphone:server:removeitem', function(item)
   local Player = QBCore.Functions.GetPlayer(source)
   Player.Functions.RemoveItem(item, 1)
end)

RegisterNetEvent('um-hackerphone:server:targetinformation', function()
   local src = source
   local PlayerPed = GetPlayerPed(src)
   local pCoords = GetEntityCoords(PlayerPed)
   local found = false
      for k, v in pairs(QBCore.Functions.GetPlayers()) do
         local TargetPed = GetPlayerPed(v)
         local tCoords = GetEntityCoords(TargetPed)
         local dist = #(pCoords - tCoords)
         if PlayerPed ~= TargetPed and dist < 3.0 then
            found = true
            TargetPlayer = QBCore.Functions.GetPlayer(v)
         end
     end
  if found then 
         local targetinfo = {
            ['targetname'] = TargetPlayer.PlayerData.charinfo.firstname,
            ['targetlastname'] = TargetPlayer.PlayerData.charinfo.lastname,
            ['targetdob'] = TargetPlayer.PlayerData.charinfo.birthdate,
            ['targetphone'] = TargetPlayer.PlayerData.charinfo.phone,
            ['targetbank'] = TargetPlayer.PlayerData.money['bank']
          }
      TriggerClientEvent('um-hackerphone:client:targetinfornui',src,targetinfo)
   else
      TriggerClientEvent('um-hackerphone:client:notify',src)
   end
end)

RegisterNetEvent('um-hackerphone:server:newtracker', function(ped, vid, vehicle)
   local src = source
   local PlayerData = GetPlayerData(src)
   local citizenid = PlayerData.citizenid
   local newtracker = MySQL.insert.await('INSERT INTO `trackers` (`cid`, `vid`, `plate`, `model`, `engine`, `distance`) VALUES (:cid, :vid, :plate, :model, :engine, :distance)',{
      cid = citizenid,
      vid = vid,
      plate = vehicle.plate,
      model = vehicle.vehname,
      engine = vehicle.vehengine,
      distance = vehicle.vehdistance,
   })
end)

--Deleted vehicle from db
RegisterNetEvent('um-hackerphone:server:removetracker', function(plate)
   local result = MySQL.single.await("SELECT * FROM `trackers` WHERE plate=:plate", { plate = plate })
			if result then
				MySQL.update("DELETE FROM `trackers` WHERE plate=:plate", { plate = plate})
			end
end)
--Check if vehicle is already in db
QBCore.Functions.CreateCallback('um-hackerphone:server:isvehicletracked', function(source, cb, plate)
	local result = MySQL.single.await("SELECT * FROM `trackers` WHERE plate=:plate", { plate = plate })
      if result ~= nil then
         cb(true)
      else
         cb(false)
      end
end)