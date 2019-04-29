local mockagne = require 'mockagne'

describe('client - markers', function()

    local coroutineSpy, drawPedMarkerSpy, drawHospitalMarkerSpy
    local coords

    before_each(function()
        _G.unpack = table.unpack
        _G.Config = {Markers = {Size = 10.0}}
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = {
            Wait = coroutine.yield,
            CreateThread = coroutine.create
        }

        require('../../src/lib/stream')
        require('../../src/client/markers')

        coroutineSpy = spy.on(_G.Citizen, 'CreateThread')
        coords = createCoords(1, 2, 3)
        drawPedMarkerSpy = spy.on(Markers, 'drawPedMarker')
        drawHospitalMarkerSpy = spy.on(Markers, 'drawHospitalMarker')
    end)

    it('StartMarkers, UpdateMarkers, SetShowHospital, StopMarkers', function()
        assertStateIsCorrect(false, false, nil, 0)

        Markers.StartMarkers(coords)
        loop = coroutineSpy['returnvals'][1].vals[1]
        iterateLoop(loop)
        assertStateIsCorrect(true, false, coords, 0)
        assertSpyCallCounts(0, 0)

        Markers.SetShowHospital(true)
        iterateLoop(loop)
        assertStateIsCorrect(true, true, coords, 0)
        assertSpyCallCounts(1, 0)

        Markers.UpdateMarkers({coords, coords, coords})
        iterateLoop(loop)
        assertStateIsCorrect(true, true, coords, 3)
        assertSpyCallCounts(2, 3)

        Markers.SetShowHospital(false)
        Markers.UpdateMarkers({coords})
        iterateLoop(loop)
        assertStateIsCorrect(true, false, coords, 1)
        assertSpyCallCounts(2, 4)

        Markers.StopMarkers()
        iterateLoop(loop)
        assertStateIsCorrect(false, false, coords, 0)
        assertSpyCallCounts(2, 4)
        assert.equals(coroutine.status(loop), 'dead')
    end)

    function createCoords(x, y, z)
        return {x = x, y = y, z = z}
    end

    function iterateLoop(loop)
        coroutine.resume(loop)
    end

    function assertStateIsCorrect(showMarkers, showHospital, hospitalMarkerPosition, markerPositionsCount)
        assert.equals(Markers.showMarkers, showMarkers)
        assert.equals(Markers.showHospital, showHospital)
        assert.equals(Markers.hospitalMarkerPosition, hospitalMarkerPosition)
        assert.equals(#Markers.markerPositions, markerPositionsCount)
    end

    function assertSpyCallCounts(drawHospitalMarkerCount, drawPedMarkerCount)
        assert.spy(drawHospitalMarkerSpy).was.called(drawHospitalMarkerCount)
        assert.spy(drawPedMarkerSpy).was.called(drawPedMarkerCount)
    end
end)