local mockagne = require 'mockagne'
local when = mockagne.when
local verify = mockagne.verify
local verifyNoCall = mockagne.verify_no_call

describe('client - peds', function()

    before_each(function()
        _G.unpack = table.unpack
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = mockagne.getMock()
        _G.Log = mockagne.getMock()

        require('../../src/lib/stream')
        require('../../src/client/peds')
    end)

    it('CreateRandomPedInArea', function()end)
    it('EnterVehicle', function()end)
    it('IsPedInVehicleOrTooFarAway - is in vehicle', function()end)
    it('IsPedInVehicleOrTooFarAway - is too far away', function()end)
    it('IsPedInVehicleOrTooFarAway - neither', function()end)
    it('DeletePeds - called with no peds', function()
        --local peds = {'Ped 1', 'Ped 2', 'Ped 3'}
        --when(_G.Wrapper.GetEntityModel())

        --Peds.DeletePeds(peds)

        --verify(_G.Citizen.Wait(10))
    end)
    it('DeletePeds - deletes all peds and unloads models', function()end)

    function createCoords(x, y, z)
        return {x = x, y = y, z = z}
    end
end)