describe('log', function()

    local printSpy

    setup(function()
        require('../../src/lib/log')
    end)

    before_each(function()
        printSpy = spy.on(_G, 'print')
    end)

    it('debug calls print when Config.DebugLog is true', function()
        _G.Config = {DebugLog = true}

        Log.debug('Test')

        assert.spy(printSpy).was.called()
        assert.spy(printSpy).was_called_with('Test')
    end)

    it('debug does not call print when Config.DebugLog is false', function()
        _G.Config = {DebugLog = false}

        Log.debug('Test')

        assert.spy(printSpy).was_not_called()
    end)
end)