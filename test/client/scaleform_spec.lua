local mockagne = require 'mockagne'
local when = mockagne.when
local verify = mockagne.verify

describe('client - scaleform', function()
    
    local threadFunctionCaptor
    local waitSpy

    before_each(function()
        _G.unpack = table.unpack
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = {
            CreateThread = function(threadFunction)
                threadFunctionCaptor = threadFunction
            end,
            Wait = function() end
        }

        waitSpy = spy.on(_G.Citizen, 'Wait')

        require('../../src/client/scaleform')
    end)

    it('ShowPassed', function()
        when(_G.Wrapper._('terminate_won')).thenAnswer('terminate_won translated')
        when(_G.Wrapper.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')).thenAnswer('scaleformObject')
        when(_G.Wrapper.HasScaleformMovieLoaded('scaleformObject')).thenAnswer(true)
        
        Scaleform.ShowPassed()

        assert.is_not_nil(threadFunctionCaptor)
        threadFunctionCaptor()

        verify(_G.Wrapper.BeginScaleformMovieMethod('scaleformObject', 'SHOW_SHARD_WASTED_MP_MESSAGE'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString('terminate_won translated'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString(''))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(5))
        verify(_G.Wrapper.EndScaleformMovieMethod())
        verify(_G.Wrapper.DrawScaleformMovieFullscreen('scaleformObject', 255, 255, 255, 255))
    end)

    it('ShowWasted', function()
        when(_G.Wrapper.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')).thenAnswer('scaleformObject')
        when(_G.Wrapper.HasScaleformMovieLoaded('scaleformObject')).thenAnswer(true)
        
        Scaleform.ShowWasted('message', 'subMessage', 1)

        assert.is_not_nil(threadFunctionCaptor)
        threadFunctionCaptor()

        verify(_G.Wrapper.BeginScaleformMovieMethod('scaleformObject', 'SHOW_SHARD_WASTED_MP_MESSAGE'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString('message'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString('subMessage'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(5))
        verify(_G.Wrapper.EndScaleformMovieMethod())
        verify(_G.Wrapper.DrawScaleformMovieFullscreen('scaleformObject', 255, 255, 255, 255))
    end)

    it('ShowMessage', function()
        when(_G.Wrapper.RequestScaleformMovie('MIDSIZED_MESSAGE')).thenAnswer('scaleformObject')
        when(_G.Wrapper.HasScaleformMovieLoaded('scaleformObject')).thenAnswer(true)
        
        Scaleform.ShowMessage('message', 'subMessage', 1)

        assert.is_not_nil(threadFunctionCaptor)
        threadFunctionCaptor()

        verify(_G.Wrapper.BeginScaleformMovieMethod('scaleformObject', 'SHOW_MIDSIZED_MESSAGE'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString('message'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString('subMessage'))
        verify(_G.Wrapper.EndScaleformMovieMethod())
        verify(_G.Wrapper.DrawScaleformMovieFullscreen('scaleformObject', 255, 255, 255, 255))
    end)

    it('ShowAddTime', function()
        when(_G.Wrapper.RequestScaleformMovie('COUNTDOWN')).thenAnswer('scaleformObject')
        when(_G.Wrapper.HasScaleformMovieLoaded('scaleformObject')).thenAnswer(true)
        
        Scaleform.ShowAddTime(5)

        assert.is_not_nil(threadFunctionCaptor)
        threadFunctionCaptor()

        verify(_G.Wrapper.BeginScaleformMovieMethod('scaleformObject', 'SET_MESSAGE'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString(5))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(30))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(30))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(255))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterBool(false))
        verify(_G.Wrapper.EndScaleformMovieMethod())
        verify(_G.Wrapper.DrawScaleformMovieFullscreen('scaleformObject', 255, 255, 255, 255))
    end)

    it('ShowRemoveTime', function()
        when(_G.Wrapper.RequestScaleformMovie('COUNTDOWN')).thenAnswer('scaleformObject')
        when(_G.Wrapper.HasScaleformMovieLoaded('scaleformObject')).thenAnswer(true)
        
        Scaleform.ShowRemoveTime(5)

        assert.is_not_nil(threadFunctionCaptor)
        threadFunctionCaptor()

        verify(_G.Wrapper.BeginScaleformMovieMethod('scaleformObject', 'SET_MESSAGE'))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterString(5))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(255))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(30))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterInt(30))
        verify(_G.Wrapper.PushScaleformMovieMethodParameterBool(false))
        verify(_G.Wrapper.EndScaleformMovieMethod())
        verify(_G.Wrapper.DrawScaleformMovieFullscreen('scaleformObject', 255, 255, 255, 255))
    end)
end)