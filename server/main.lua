ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('blargleambulance:finishLevel')
AddEventHandler('blargleambulance:finishLevel', function(levelFinished)
    ESX.GetPlayerFromId(source).addMoney(Config.MoneyPerLevelFormula(levelFinished))
end)