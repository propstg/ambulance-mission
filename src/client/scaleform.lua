Scaleform = {}

function Scaleform.ShowPassed()
    Scaleform.ShowWasted(Wrapper._('terminate_won'), '', 5)
end

function Scaleform.ShowWasted(message, subMessage, secondsToShow)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.loadScaleform('MP_BIG_MESSAGE_FREEMODE')

        Wrapper.BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
        Wrapper.PushScaleformMovieMethodParameterString(message)
        Wrapper.PushScaleformMovieMethodParameterString(subMessage)
        Wrapper.PushScaleformMovieMethodParameterInt(5)
        Wrapper.EndScaleformMovieMethod()

        Scaleform.draw(scaleform, secondsToShow * 50, 0)
    end)
end

function Scaleform.ShowMessage(message, subMessage, secondsToShow)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.loadScaleform('MIDSIZED_MESSAGE')

        Wrapper.BeginScaleformMovieMethod(scaleform, 'SHOW_MIDSIZED_MESSAGE')
        Wrapper.PushScaleformMovieMethodParameterString(message)
        Wrapper.PushScaleformMovieMethodParameterString(subMessage)
        Wrapper.EndScaleformMovieMethod()

        Scaleform.draw(scaleform, secondsToShow * 50, 1)
    end)
end

function Scaleform.ShowAddTime(time)
    Scaleform.showCountDown(time, 30, 30, 255)
end

function Scaleform.ShowRemoveTime(time)
    Scaleform.showCountDown(time, 255, 30, 30)
end

function Scaleform.ShowAddMoney(money)
    Scaleform.showCountDown(money, 30, 255, 30)
end

function Scaleform.showCountDown(text, r, g, b)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.loadScaleform('COUNTDOWN')

        Wrapper.BeginScaleformMovieMethod(scaleform, 'SET_MESSAGE')
        Wrapper.PushScaleformMovieMethodParameterString(text)
        Wrapper.PushScaleformMovieMethodParameterInt(r)
        Wrapper.PushScaleformMovieMethodParameterInt(g)
        Wrapper.PushScaleformMovieMethodParameterInt(b)
        Wrapper.PushScaleformMovieMethodParameterBool(false)
        Wrapper.EndScaleformMovieMethod()

        Scaleform.draw(scaleform, 40, 10)
    end)
end

function Scaleform.loadScaleform(scaleformName)
    local scaleform = Wrapper.RequestScaleformMovie(scaleformName)

    while not Wrapper.HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    return scaleform
end

function Scaleform.draw(scaleform, loops, delayBetweenLoops)
    for i = 1, loops do
        Wrapper.DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        Citizen.Wait(delayBetweenLoops)
    end
end