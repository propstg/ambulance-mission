local mockagne = require 'mockagne'
local when = mockagne.when
local any = mockagne.any
local verify = mockagne.verify

describe('server - main', function()

    setup(function()
        _G.unpack = table.unpack
        _G.Config = {Formulas = {moneyPerLevel = function(level) return 5 * level end}}
        _G.Wrapper = mockagne.getMock()
        _G.source = 'source'

        require('../../src/lib/stream')
        require('../../src/server/main')
    end)

    it('verify esx event triggered', function()
        verify(_G.Wrapper.TriggerEvent('esx:getSharedObject', any()))
    end)

    it('verify finish level events registered', function()
        verify(_G.Wrapper.RegisterNetEvent('blargleambulance:finishLevel'))
        verify(_G.Wrapper.AddEventHandler('blargleambulance:finishLevel', any()))
    end)

    it('finishLevel called -- finds player based on source and awards level-appropriate amount of money', function()
        local esxMock = mockagne.getMock()
        local playerMock = mockagne.getMock()
        getFunctionFromNativeCall('TriggerEvent', 'esx:getSharedObject')(esxMock)
        when(esxMock.GetPlayerFromId('source')).thenAnswer(playerMock)

        getFunctionFromNativeCall('AddEventHandler', 'blargleambulance:finishLevel')(5)

        verify(playerMock.addMoney(25))
    end)

    function getFunctionFromNativeCall(nativeName, eventName)
        return Stream.of(_G.Wrapper.stored_calls)
            .filter(function(wrapperCall) return wrapperCall.key == nativeName end)
            .filter(function(wrapperCall) return wrapperCall.args[1] == eventName end)
            .map(function(wrapperCall) return wrapperCall.args[2] end)
            .collect()[1]
    end
end)