local mockagne = require 'mockagne'
local when = mockagne.when
local verify = mockagne.verify
local verifyNoCall = mockagne.verify_no_call

describe('client - main', function()
    
    before_each(function()
        _G.TEST = true
        _G.unpack = table.unpack
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = mockagne.getMock()
        _G.Blips = mockagne.getMock()
        _G.Markers = mockagne.getMock()
        _G.Config = {
            MaxPatientsPerTrip = 3
        }

        require('../../src/lib/stream')
        require('../../src/client/main')
    end)

    pending('TODO:  write tests for main')

    it('findFirstFreeSeat - has free seat', function()
        playerData.vehicle = 'vehicleObject'
        when(_G.Wrapper.IsVehicleSeatFree('vehicleObject', 1)).thenAnswer(false)
        when(_G.Wrapper.IsVehicleSeatFree('vehicleObject', 2)).thenAnswer(true)

        assert.equals(2, findFirstFreeSeat())

        verifyNoCall(_G.Wrapper.IsVehicleSeatFree('vehicleObject', 3))
    end)

    it('findFirstFreeSeat - no free seats', function()
        playerData.vehicle = 'vehicleObject'
        when(_G.Wrapper.IsVehicleSeatFree('vehicleObject', 1)).thenAnswer(false)
        when(_G.Wrapper.IsVehicleSeatFree('vehicleObject', 2)).thenAnswer(false)
        when(_G.Wrapper.IsVehicleSeatFree('vehicleObject', 3)).thenAnswer(false)

        assert.equals(0, findFirstFreeSeat())
    end)

    it('updateMarkersAndBlips - no peds', function()
        gameData.peds = {}
        gameData.pedsInAmbulance = {}

        updateMarkersAndBlips()

        verify(_G.Blips.UpdateBlips({}))
        verify(_G.Markers.UpdateMarkers({}))
        verify(_G.Blips.SetFlashHospital(false))
        verify(_G.Markers.SetShowHospital(false))
    end)

    it('updateMarkersAndBlips - has peds', function()
        gameData.peds = {{coords = 1}, {coords = 2}}
        gameData.pedsInAmbulance = {{coords = 3}, {coords = 4}}

        updateMarkersAndBlips()

        verify(_G.Blips.UpdateBlips({1, 2}))
        verify(_G.Markers.UpdateMarkers({1, 2}))
        verify(_G.Blips.SetFlashHospital(true))
        verify(_G.Markers.SetShowHospital(true))
    end)

    it('playSound calls native', function()
        local sound = {
            audioName = 'AudioName',
            audioRef = 'AudioRef'
        }

        playSound(sound)

        verify(_G.Wrapper.PlaySoundFrontend(-1, 'AudioName', 'AudioRef', 1))
    end)
end)