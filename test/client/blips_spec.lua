local mockagne = require 'mockagne'
local when = mockagne.when
local verify = mockagne.verify
local verifyNoCall = mockagne.verify_no_call

describe('client - blips', function()

    before_each(function()
        _G.unpack = table.unpack
        _G.Wrapper = mockagne.getMock()

        when(_G.Wrapper._('blip_hospital')).thenAnswer('hospital translated')
        when(_G.Wrapper._('blip_patient')).thenAnswer('patient translated')

        require('../../src/lib/stream')
        require('../../src/client/blips')
    end)

    it('StartBlips -- creates blip for hospital', function()
        local blip = {}
        when(_G.Wrapper.AddBlipForCoord(1, 2, 3)).thenAnswer(blip)
        
        Blips.StartBlips(createCoords(1, 2, 3))

        verify(_G.Wrapper.SetBlipSprite(blip, 61))
        verify(_G.Wrapper.SetBlipAsShortRange(blip, true))
        verify(_G.Wrapper.SetBlipFlashes(blip, false))
        verify(_G.Wrapper.BeginTextCommandSetBlipName('STRING'))
        verify(_G.Wrapper.AddTextComponentString('hospital translated'))
        verify(_G.Wrapper.EndTextCommandSetBlipName(blip))
    end)

    it('UpdateBlips -- does not call RemoveBlips when no existing patients', function()
        Blips.UpdateBlips({})

        verifyNoCall(_G.Wrapper.RemoveBlip)
    end)

    it('UpdateBlips -- calls RemoveBlips when existing patients', function()
        Blips.patientBlips = {'Blip 1', 'Blip 2', 'Blip 3'}
        
        Blips.UpdateBlips({})

        verify(_G.Wrapper.RemoveBlip('Blip 1', 1))
        verify(_G.Wrapper.RemoveBlip('Blip 2', 2))
        verify(_G.Wrapper.RemoveBlip('Blip 3', 3))
    end)

    it('UpdateBlips -- creates blip for each coordinate passed in', function()
        local blips = {{}, {}, {}}
        when(_G.Wrapper.AddBlipForCoord(1, 2, 3)).thenAnswer(blips[1])
        when(_G.Wrapper.AddBlipForCoord(2, 3, 4)).thenAnswer(blips[2])
        when(_G.Wrapper.AddBlipForCoord(3, 4, 5)).thenAnswer(blips[3])
        
        Blips.UpdateBlips({createCoords(1, 2, 3), createCoords(2, 3, 4), createCoords(3, 4, 5)})

        for _, blip in pairs(blips) do
            verify(_G.Wrapper.SetBlipSprite(blip, 3))
            verify(_G.Wrapper.SetBlipAsShortRange(blip, true))
            verify(_G.Wrapper.SetBlipFlashes(blip, true))
            verify(_G.Wrapper.BeginTextCommandSetBlipName('STRING'))
            verify(_G.Wrapper.AddTextComponentString('patient translated'))
            verify(_G.Wrapper.EndTextCommandSetBlipName(blip))
        end
    end)
    
    it('StopBlips -- removes all patient blips and removes hospital blip', function()
        Blips.patientBlips = {'Blip 1', 'Blip 2', 'Blip 3'}
        Blips.hospitalBlip = 'hospital blip'
        
        Blips.StopBlips()

        verify(_G.Wrapper.RemoveBlip('Blip 1', 1))
        verify(_G.Wrapper.RemoveBlip('Blip 2', 2))
        verify(_G.Wrapper.RemoveBlip('Blip 3', 3))
        verify(_G.Wrapper.RemoveBlip('hospital blip'))
    end)

    it('SetFlashHospital -- calls native on hospital blip when set to true', function()
        Blips.hospitalBlip = 'hospital blip'

        Blips.SetFlashHospital(true)

        verify(_G.Wrapper.SetBlipFlashes('hospital blip', true))
    end)

    it('SetFlashHospital -- calls native on hospital blip when set to false', function()
        Blips.hospitalBlip = 'hospital blip'

        Blips.SetFlashHospital(false)

        verify(_G.Wrapper.SetBlipFlashes('hospital blip', false))
    end)

    function createCoords(x, y, z)
        return {x = x, y = y, z = z}
    end
end)