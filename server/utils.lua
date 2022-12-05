local QBCore = exports['qb-core']:GetCoreObject()

function GetPlayerData(source)
	local Player = QBCore.Functions.GetPlayer(source)
	return Player.PlayerData
end

function GetNameFromPlayerData(PlayerData)
	return ('%s %s'):format(PlayerData.charinfo.firstname, PlayerData.charinfo.lastname)
end
