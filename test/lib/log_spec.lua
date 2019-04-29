local mockagne = require 'mockagne'
local verify = mockagne.verify
local verifyNoCall = mockagne.verify_no_call

describe('log', function()

    setup(function()
        _G.unpack = table.unpack
        require('../../src/lib/log')
    end)

    before_each(function()
        _G.Wrapper = mockagne.getMock()
    end)

    it('debug calls print when Config.DebugLog is true', function()
        _G.Config = {DebugLog = true}

        Log.debug('Test')

        verify(_G.Wrapper.print('Test'))
    end)

    it('debug does not call print when Config.DebugLog is false', function()
        _G.Config = {DebugLog = false}

        Log.debug('Test')

        verifyNoCall(_G.Wrapper.print('Test'))
    end)
end)