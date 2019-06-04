local mockagne = require 'mockagne'
local when = mockagne.when
local any = mockagne.any
local verify = mockagne.verify

describe('client - peds', function()

    local deletePedSpy

    before_each(function()
        _G.unpack = table.unpack
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = mockagne.getMock()
        _G.Log = mockagne.getMock()
        _G.Config = {
            Markers = {Size = 10.0},
            EnterVehicleTimeout = 1000,
            PedDamagePacks = {'Pack 1'},
            PedModels = {'Model 1', 'Model 2'}
        }

        require('../../src/lib/stream')
        require('../../src/client/peds')

        deletePedSpy = spy.on(Peds, 'deletePed')
    end)

    it('CreateRandomPedInArea', function()
        when(_G.Wrapper.GetHashKey('Model 2')).thenAnswer('Model 2 Hash')
        when(_G.Wrapper.HasModelLoaded('Model 2 Hash')).thenAnswer(false)
        when(_G.Wrapper.GetHashKey('Model 1')).thenAnswer('Model 1 Hash')
        when(_G.Wrapper.HasModelLoaded('Model 1 Hash')).thenAnswer(true)
        when(_G.Wrapper.CreatePed(4, 'Model 1', any(), any(), any(), any(), true, false)).thenAnswer('pedObject')

        local result = Peds.CreateRandomPedInArea(createCoords(1, 2, 3))

        assert.equals(result.model, 'pedObject')
        assert.is_not_nil(result.coords)
        assert.is_true(math.abs(1 - result.coords.x) <= 2)
        assert.is_true(math.abs(2 - result.coords.y) <= 2)
        assert.is_true(math.abs(3 - result.coords.z) <= 2)

        verify(_G.Wrapper.RequestModel('Model 1 Hash'))
        verify(_G.Wrapper.ApplyPedDamagePack('pedObject', 'Pack 1', 100.0, 100.0))
        verify(_G.Wrapper.TaskWanderInArea('pedObject', any(), any(), any(), 5.0, 5.0, 5000))
        verify(_G.Wrapper.SetEntityInvincible('pedObject', true))
    end)
    
    it('EnterVehicle', function()
        Peds.EnterVehicle('pedObject', 'vehicleObject', 1)

        verify(_G.Citizen.Wait(10))
        verify(_G.Wrapper.TaskEnterVehicle('pedObject', 'vehicleObject', 1000, 1, 2.0, 1, 0))
    end)
    
    it('IsPedInVehicleOrTooFarAway - is in vehicle', function()
        when(_G.Wrapper.IsPedInAnyVehicle('pedObject', false)).thenAnswer(true)

        local result = Peds.IsPedInVehicleOrTooFarAway('pedObject', createCoords(1, 2, 3))

        assert.is_true(result)
    end)

    it('IsPedInVehicleOrTooFarAway - is too far away', function()
        local coords = createCoords(100, 2, 3)
        when(_G.Wrapper.IsPedInAnyVehicle('pedObject', false)).thenAnswer(false)
        when(_G.Wrapper.GetEntityCoords('pedObject')).thenAnswer(coords)
        when(_G.Wrapper.GetDistanceBetweenCoords(coords, 1, 2, 3)).thenAnswer(50)

        local result = Peds.IsPedInVehicleOrTooFarAway('pedObject', createCoords(1, 2, 3))

        assert.is_true(result)
    end)

    it('IsPedInVehicleOrTooFarAway - neither', function()
        local coords = createCoords(1, 2, 3)
        when(_G.Wrapper.IsPedInAnyVehicle('pedObject', false)).thenAnswer(false)
        when(_G.Wrapper.GetEntityCoords('pedObject')).thenAnswer(coords)
        when(_G.Wrapper.GetDistanceBetweenCoords(coords, 1, 2, 3)).thenAnswer(0)

        local result = Peds.IsPedInVehicleOrTooFarAway('pedObject', createCoords(1, 2, 3))

        assert.is_false(result)
    end)

    it('DeletePeds - called with no peds', function()
        Peds.DeletePeds({})

        assert.spy(deletePedSpy).was_not.called()
    end)
    
    it('DeletePeds - deletes all peds and unloads models', function()
        Peds.modelsHashUsedByPedCount = {
            ['Ped 1 Model'] = 1,
            ['Ped 2 Model'] = 1,
        }

        local peds = {'Ped 1', 'Ped 2', 'Ped 3'}
        when(_G.Wrapper.GetEntityModel('Ped 1')).thenAnswer('Ped 1 Model')
        when(_G.Wrapper.GetEntityModel('Ped 2')).thenAnswer('Ped 2 Model')
        when(_G.Wrapper.GetEntityModel('Ped 3')).thenAnswer('Ped 3 Model')

        Peds.DeletePeds(peds)

        assert.spy(deletePedSpy).was.called(3)
        verify(_G.Wrapper.SetModelAsNoLongerNeeded('Ped 1 Model'))
        verify(_G.Wrapper.SetModelAsNoLongerNeeded('Ped 2 Model'))
        verify(_G.Wrapper.SetModelAsNoLongerNeeded('Ped 3 Model'))
        verify(_G.Wrapper.SetEntityAsNoLongerNeeded('Ped 1'))
        verify(_G.Wrapper.SetEntityAsNoLongerNeeded('Ped 2'))
        verify(_G.Wrapper.SetEntityAsNoLongerNeeded('Ped 3'))
        verify(_G.Wrapper.DeletePed('Ped 1'))
        verify(_G.Wrapper.DeletePed('Ped 2'))
        verify(_G.Wrapper.DeletePed('Ped 3'))
    end)

    function createCoords(x, y, z)
        return {x = x, y = y, z = z}
    end
end)