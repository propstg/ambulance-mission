Peds = {}
Peds.modelsHashUsedByPedCount = {}

function Peds.CreateRandomPedInArea(coords)
    local modelName = Peds.loadModel(Peds.randomlySelectModel())

    local x = coords.x + math.random() * 4 - 2
    local y = coords.y + math.random() * 4 - 2
    local heading = math.random() * 360
    local pedDamagePack = Config.PedDamagePacks[math.random(#Config.PedDamagePacks)]

    local ped = Wrapper.CreatePed(4, modelName, x, y, coords.z, heading, true, false)
    Wrapper.ApplyPedDamagePack(ped, pedDamagePack, 100.0, 100.0)
    Peds.wanderInArea(ped, coords)
    Peds.incrementModelsHashUsedByPedCount(modelName)
    Peds.SetInvincibility(ped, true)

    return {
        model = ped,
        coords = {x = x, y = y, z = coords.z}
    }
end

function Peds.wanderInArea(ped, stopCoords)
    Wrapper.TaskWanderInArea(ped,
        stopCoords.x,
        stopCoords.y,
        stopCoords.z,
        Config.Markers.Size / 2.0, -- radius
        Config.Markers.Size / 2.0, -- minimalLength
        5000                       -- timeBetweenWalks
    )
end

function Peds.SetInvincibility(ped, isInvincible)
    Wrapper.SetEntityInvincible(ped, isInvincible)
end

function Peds.EnterVehicle(ped, vehicle, seatNumber)
    Citizen.Wait(10)
    Wrapper.TaskEnterVehicle(ped,
        vehicle,
        Config.EnterVehicleTimeout, -- timeout
        seatNumber,                 -- seat
        2.0,                        -- speed (run)
        1,                          -- flag, normal
        0                           -- p6? lol
    )
end

function Peds.IsPedInVehicleOrTooFarAway(ped, position)
    if Wrapper.IsPedInAnyVehicle(ped, false) then
        return true
    end

    return Wrapper.GetDistanceBetweenCoords(Wrapper.GetEntityCoords(ped), position.x, position.y, position.z) > 15
end

function Peds.loadModel(modelName)
    local loadAttempts = 0
    local hashKey = Wrapper.GetHashKey(modelName)

    Wrapper.RequestModel(hashKey)
    while not Wrapper.HasModelLoaded(hashKey) and loadAttempts < 10 do
        loadAttempts = loadAttempts + 1
        Citizen.Wait(50)
    end

    if loadAttempts == 10 then
        Log.debug('MODEL NOT LOADED AFTER TEN ATTEMPTS: ' .. modelName)
        return Peds.loadModel(Peds.randomlySelectModel())
    end

    Log.debug('Successfully loaded model: ' .. modelName)
    return modelName
end

function Peds.DeletePeds(pedList)
    while #pedList > 0 do
        Peds.deletePed(table.remove(pedList))
        Citizen.Wait(10)
    end
end

function Peds.deletePed(ped)
    Peds.handleUnloadingModelIfNeeded(ped)
    Wrapper.SetEntityAsNoLongerNeeded(ped)
    Wrapper.DeletePed(ped)
end

function Peds.randomlySelectModel()
    return Config.PedModels[math.random(#Config.PedModels)]
end

function Peds.incrementModelsHashUsedByPedCount(modelName)
    local hashKey = Wrapper.GetHashKey(modelName)

    local value = Peds.modelsHashUsedByPedCount[hashKey]
    if value == nil then value = 0 end

    Peds.modelsHashUsedByPedCount[hashKey] = value + 1
end

function Peds.handleUnloadingModelIfNeeded(pedToDelete)
    local hashKey = Wrapper.GetEntityModel(pedToDelete)
    Peds.decrementModelsHashUsedByPedCount(hashKey)
    if Peds.modelsHashUsedByPedCount[hashKey] <= 0 then
        Wrapper.SetModelAsNoLongerNeeded(hashKey)
    end
end

function Peds.decrementModelsHashUsedByPedCount(hashKey)
    local value = Peds.modelsHashUsedByPedCount[hashKey]
    if value == nil then value = 1 end

    Peds.modelsHashUsedByPedCount[hashKey] = value - 1
end
