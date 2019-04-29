ESX = nil

Wrapper.TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Wrapper.RegisterNetEvent('blargleambulance:finishLevel')
Wrapper.AddEventHandler('blargleambulance:finishLevel', function(levelFinished)
    ESX.GetPlayerFromId(source).addMoney(Config.Formulas.moneyPerLevel(levelFinished))
end)