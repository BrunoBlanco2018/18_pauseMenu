Framework = Config.Framework == "qb" and exports['qb-core']:GetCoreObject() or exports['es_extended']:getSharedObject()

function registerServerCallback(...)
	if Config.Framework == "qb" then
		Framework.Functions.CreateCallback(...)
	else
		Framework.RegisterServerCallback(...)
	end
end

RegisterServerEvent('18_pausemenu:exit')
AddEventHandler('18_pausemenu:exit', function()
    DropPlayer(source, "Exited")
end)

registerServerCallback("18_pausemenu:getPlayerData", function(src, cb)
    local xPlayer = Config.Framework == "esx" and Framework.GetPlayerFromId(src) or Framework.Functions.GetPlayer(src)
    playerId = src
    players = GetPlayers()
    policeCount = 0

    for _, playerId in ipairs(players) do
        local player = Config.Framework == "esx" and Framework.GetPlayerFromId(playerId) or Framework.Functions.GetPlayer(playerId)
        local job = Config.Framework == "esx" and player.getJob().name or player.PlayerData.job.name

        if job == "police" then
            policeCount = policeCount + 1
        end
    end

    if Config.Framework == "esx" then
        cash = xPlayer.getAccount("money").money
        bank = xPlayer.getAccount("bank").money
        name = xPlayer.getName()
        job = xPlayer.getJob().name
    else
        cash = xPlayer.PlayerData.money.cash
        bank = xPlayer.PlayerData.money.bank
        job = xPlayer.PlayerData.job.name
        name = xPlayer.PlayerData.firstname.." "..xPlayer.PlayerData.lastname
    end

    cb({policeCount = policeCount ,bank = bank, wallet = cash, name = name, job = job})
end)