local Ref = {}

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- Event For Sync Class, Server > Client
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        TriggerClientEvent('ref:client:getClassTableAndSync', -1, Ref)
    end
end)

SyncAll = function()
    TriggerClientEvent('ref:client:getClassTableAndSync', -1, Ref)
end

RegisterServerEvent('ref:server:changeStateRef')
AddEventHandler('ref:server:changeStateRef', function()
    local _src = source

    if Ref[_src] then
        Ref[_src].ToggleRef()
    else
        Ref[_src] = NewRef(_src)
        Wait(50)
        Ref[_src].ToggleRef()
    end

    SyncAll()
end)

RegisterServerEvent('ref:server:DeletePolice')
AddEventHandler('ref:server:DeletePolice', function()
    local _src = source

    if Ref[_src] then
        Ref[_src] = nil
    end

    SyncAll()
end)

AddEventHandler('playerDropped', function(data)
    local _src = source

    if Ref[_src] then
        Ref[_src].state = false
        Ref[_src] = nil
    end

    SyncAll()
end)