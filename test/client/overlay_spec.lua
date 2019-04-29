local mockagne = require 'mockagne'
local when = mockagne.when
local any = mockagne.any
local verify = mockagne.verify

describe('client - overlay', function()
    
    setup(function()
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

        coroutineSpy = spy.on(_G.Citizen, 'CreateThread')
    end)

    it('Functional test', function()
        local gameData = {
            secondsLeft = 100,
            level = 1,
            peds = {'ped'},
            pedsInAmbulance = {'ped 2'}
        }
        when(_G.Wrapper.jsonEncode(any())).thenAnswer('encodedJson')

        assertStateIsCorrect(false, false)

        Overlay.Init()
        assertStateIsCorrect(false, false)
        verify(_G.Wrapper.SendNuiMessage('encodedJson'))
        verify(_G.Wrapper.jsonEncode({type = 'init', translatedLabels = _G.Locales.en}))

        Overlay.Start(gameData)
        assertStateIsCorrect(false, true)
        verify(_G.Wrapper.jsonEncode({type = 'tick', timeLeft = '01:40', level = 1, emptySeats = 2, patientsLeft = 1}))
        verify(_G.Wrapper.jsonEncode({type = 'changeVisibility', visible = true}))

        gameData.secondsLeft = 9
        gameData.peds = {}
        gameData.pedsInAmbulance = {'ped', 'ped 2'}

        Overlay.Update(gameData)
        assertStateIsCorrect(false, true)
        verify(_G.Wrapper.jsonEncode({type = 'tick', timeLeft = '00:09', level = 1, emptySeats = 1, patientsLeft = 0}))

        loop = coroutineSpy['returnvals'][1].vals[1]
        
        iterateLoop(loop)
        assertStateIsCorrect(false, true)

        when(_G.Wrapper.IsPauseMenuActive()).thenAnswer(true)

        iterateLoop(loop)
        assertStateIsCorrect(true, true)
        verify(_G.Wrapper.jsonEncode({type = 'changeVisibility', visible = false}))

        Overlay.Stop()
        assertStateIsCorrect(false, false)
        
        iterateLoop(loop)
        assert.equals('dead', coroutine.status(loop))
    end)

    function iterateLoop(loop)
        coroutine.resume(loop)
    end

    function assertStateIsCorrect(wasPaused, isVisible)
        assert.equals(wasPaused, Overlay.wasPaused)
        assert.equals(isVisible, Overlay.isVisible)
    end

    function assertSpyCallCounts(drawHospitalMarkerCount, drawPedMarkerCount)
        assert.spy(drawHospitalMarkerSpy).was.called(drawHospitalMarkerCount)
        assert.spy(drawPedMarkerSpy).was.called(drawPedMarkerCount)
    end
end)