local mockagne = require 'mockagne'
local when = mockagne.when
local any = mockagne.any
local verify = mockagne.verify

describe('client - overlay - rpmode', function()
    
    before_each(function()
        _G.unpack = table.unpack
        _G.Locales = {
            en = {
                all = 'message',
                translations = 'here'
            }
        }
        _G.Config = {
            Locale = 'en',
            MaxPatientsPerTrip = 3
        }
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = {
            Wait = coroutine.yield,
            CreateThread = coroutine.create
        }

        require('../../src/client/overlay')
    end)

    it('should not start thread when Config.RpMode is true', function()
        _G.Config.RpMode = true
    
        local gameData = {
            secondsLeft = 100,
            level = 1,
            peds = {'ped'},
            pedsInAmbulance = {'ped 2'},
            maxPatientsPerTrip = 3
        }
        when(_G.Wrapper.jsonEncode(any())).thenAnswer('encodedJson')

        assertStateIsCorrect(false, false)

        Overlay.Init()
        assertStateIsCorrect(false, false)
        verify(_G.Wrapper.SendNuiMessage('encodedJson'))
        verify(_G.Wrapper.jsonEncode({type = 'init', translatedLabels = _G.Locales.en}))

        Overlay.Start(gameData)
        assertStateIsCorrect(false, false)
    end)

    function assertStateIsCorrect(wasPaused, isVisible)
        assert.equals(wasPaused, Overlay.wasPaused)
        assert.equals(isVisible, Overlay.isVisible)
    end
end)
