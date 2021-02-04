ESX = nil

Wrapper.TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Wrapper.RegisterNetEvent('blargleambulance:finishLevel')
Wrapper.AddEventHandler('blargleambulance:finishLevel', function(levelFinished)
    ESX.GetPlayerFromId(source).addMoney(Config.Formulas.moneyPerLevel(levelFinished))
end)

Wrapper.RegisterNetEvent('blargleambulance:patientsDelivered')
--luacheck: no unused args
Wrapper.AddEventHandler('blargleambulance:patientsDelivered', function(numberOfPatients)
    -- Add custom code here. Trigger client event blargleambulance:terminateGame('reason') if needed
end)