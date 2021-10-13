QBCore = nil
cooldown = {}

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("xp-caixinha:sv:pendrive")
AddEventHandler("xp-caixinha:sv:pendrive", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local pendrive_green = Player.Functions.GetItemByName("pendrive_green")
    local pendrive = QBCore.Shared.Items["pendrive_green"]

    if pendrive_green ~= nil and pendrive_green.amount >= 1 then
        if cooldown[Player.PlayerData.citizenid] == nil then
            Citizen.CreateThread(function()
                Player.Functions.RemoveItem('pendrive_green', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
                TriggerClientEvent("xp-caixinha:cl:progressbar", src)
                Citizen.Wait(10000)
    
                TriggerClientEvent("xp-caixinha:cl:minigame", src)
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Aguarde antes de tentar hackear novamente!', 'inform')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'ERROR 404', 'error')
    end
end)

RegisterServerEvent("xp-caixinha:sv:bills")
AddEventHandler("xp-caixinha:sv:bills", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local bills = QBCore.Shared.Items["bills"]
    Player.Functions.AddItem('bills', math.random(1000,2000))
    TriggerClientEvent('inventory:client:ItemBox', source, bills, "add")
end)

RegisterServerEvent("xp-caixinha:sv:cd")
AddEventHandler("xp-caixinha:sv:cd", function()
    local Player = QBCore.Functions.GetPlayer(source)


    cooldown[Player.PlayerData.citizenid] = 1

    Citizen.CreateThread(function()
        Citizen.Wait(15 * (60 * 1000))
        cooldown[Player.PlayerData.citizenid] = nil
    end)
end)

