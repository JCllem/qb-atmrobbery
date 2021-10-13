QBCore = nil
local CurrentCops = 0

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent("xp-caixinha:cl:olho")
AddEventHandler("xp-caixinha:cl:olho",function()
    if CurrentCops >= 1 then
        TriggerServerEvent("xp-caixinha:sv:pendrive")
        TriggerEvent("police-dispatch:atm")
    else
        QBCore.Functions.Notify("Não há policiais suficientes", "error")
    end
end)

RegisterNetEvent("xp-caixinha:cl:minigame")
AddEventHandler("xp-caixinha:cl:minigame",function()
    exports["memorygame"]:thermiteminigame(10, 3, 3, 20,
    function() -- success
        QBCore.Functions.Notify("Sistema invadido.", "success") 
        TriggerServerEvent("xp-caixinha:sv:bills")
        TriggerServerEvent("xp-caixinha:sv:cd")
        TriggerServerEvent('XP:Hud:Server:GainStress', math.random(2, 4))
    end,
    function() -- failure
        QBCore.Functions.Notify("Não foi dessa vez.", "error")
        TriggerServerEvent('XP:Hud:Server:GainStress', math.random(4, 7))
    end)
end)

RegisterNetEvent("xp-caixinha:cl:progressbar")
AddEventHandler("xp-caixinha:cl:progressbar", function()
    QBCore.Functions.Progressbar("coke_destroy", "Estabelecendo Conexão", 10000, false, false, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@gangops@facility@servers@",
        anim = "hotwire",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        isDoingAction = false
        ClearPedTasksImmediately(ped)
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        QBCore.Functions.Notify("Cancelado", "error")
    end)
end)