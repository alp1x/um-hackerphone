local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("hackerphone", function(source)
   TriggerClientEvent('um-hackerphone:client:openphone',source)
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

