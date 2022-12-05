local QBCore = exports['qb-core']:GetCoreObject()

-- Get CitizenIDs from Player License
function GetCitizenID(license)
    local result = MySQL.query.await("SELECT citizenid FROM players WHERE license = ?", {license,})
    if result ~= nil then
        return result
    else
        print("Cannot find a CitizenID for License: "..license)
        return nil
    end
end

function GetNameFromId(cid)
	local result = MySQL.scalar.await('SELECT charinfo FROM players WHERE citizenid = @citizenid', { ['@citizenid'] = cid })
    if result ~= nil then
        local charinfo = json.decode(result)
        local fullname = charinfo['firstname']..' '..charinfo['lastname']
        return fullname
    else
        --print('Player does not exist')
        return nil
    end
	-- return exports.oxmysql:executeSync('SELECT firstname, lastname FROM `users` WHERE id = :id LIMIT 1', { id = cid })
end

function GetPlayerVehicles(cid, cb)
	return MySQL.query.await('SELECT id, plate, vehicle FROM player_vehicles WHERE citizenid=:cid', { cid = cid })
end

function GetPlayerDataById(id)
    local Player = QBCore.Functions.GetPlayerByCitizenId(id)
    if Player ~= nil then
		local response = {citizenid = Player.PlayerData.citizenid, charinfo = Player.PlayerData.charinfo, metadata = Player.PlayerData.metadata, job = Player.PlayerData.job}
        return response
    else
        return MySQL.single.await('SELECT citizenid, charinfo, job, metadata FROM players WHERE citizenid = ? LIMIT 1', { id })
    end

	-- return exports.oxmysql:executeSync('SELECT citizenid, charinfo, job FROM players WHERE citizenid = ? LIMIT 1', { id })
end