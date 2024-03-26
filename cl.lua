local isOpen = false
local Framework = Config.Framework == "qb" and exports['qb-core']:GetCoreObject() or exports['es_extended']:getSharedObject()

RegisterNetEvent('abrirMapa')

AddEventHandler('abrirMapa', function()
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 1, -1) 
    SetNuiFocus(false, false)
    isOpen = false
end)

RegisterNUICallback("openMap", function(data, cb)
    TriggerEvent('abrirMapa')
end)

RegisterNUICallback("openSettings", function(data, cb)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 1, -1) 
    SetNuiFocus(false, false)
    isOpen = false
end)

RegisterNUICallback("exit", function(data, cb)
    SetNuiFocus(false, false)
    isOpen = false
    TriggerServerEvent('18_pausemenu:exit')
end)

RegisterKeyMapping('OpenPauseMenu', 'Open Pause Menu', 'keyboard', 'ESCAPE')

RegisterCommand('OpenPauseMenu', function()
    if GetCurrentFrontendMenuVersion() == -1 and not IsNuiFocused() then
        isOpen = false
        OpenPauseMenu()
    end
end)

RegisterNUICallback("setFocus", function(data, cb)
    SetNuiFocus(false, false)
    isOpen = false
end)

CreateThread(function()
    while true do 
        if isOpen then
            SetPauseMenuActive(false)
        end

        Wait(1)
    end
end)

function triggerServerCallback(...)
	if Config.Framework == "qb" then
		Framework.Functions.TriggerCallback(...)
	else
		Framework.TriggerServerCallback(...)
	end
end

function OpenPauseMenu()
    triggerServerCallback("18_pausemenu:getPlayerData", function(cb)
        if isOpen then
            isOpen = false
            SetNuiFocus(false, false)
            SendNUIMessage({
                open = false,
            })
        else
            isOpen = true
            SetNuiFocus(true, true)
            SendNUIMessage({
                open = true,
                job = cb.job,
                cash = cb.wallet,
                bank = cb.bank,
                name = cb.name,
                policeCount = cb.policeCount
            })
        end
    end)
end
