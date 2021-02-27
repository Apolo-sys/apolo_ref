local t = {}
local n = {}
local r = "unemployed"
ESX = nil
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(e)
                    ESX = e
                end
            )
            Citizen.Wait(500)
        end
    end
)
RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(e)
        ESX.PlayerData.job = e
        r = e
    end
)
RegisterCommand(
    "ref",
    function(e, e)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "police" then
            print(ESX.PlayerData.job.name)
            TriggerServerEvent("ref:server:changeStateRef")
        end
    end
)
DeleteFromClass = function()
    Wait(2500)
    TriggerServerEvent("ref:server:DeletePolice")
end
RegisterNetEvent("ref:client:getClassTableAndSync")
AddEventHandler(
    "ref:client:getClassTableAndSync",
    function(e)
        local r = GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1)))
        n = e
        for n, e in pairs(n) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == "police" then
                if not t[e.id] and e.state then
                    t[e.id] = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(e.id)))
                    SetBlipColour(t[e.id], 0)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentSubstringPlayerName(GetPlayerName(GetPlayerFromServerId(e.id)))
                    EndTextCommandSetBlipName(t[e.id])
                elseif not e.state then
                    RemoveBlip(t[e.id])
                    t[e.id] = nil
                end
            elseif e.id == r and e.state then
                TriggerServerEvent("ref:server:changeStateRef")
                for n, e in pairs(t) do
                    RemoveBlip(e)
                end
                t = {}
                DeleteFromClass()
            end
        end
    end
)
