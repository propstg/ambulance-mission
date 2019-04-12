Scaleform = {}

function Scaleform.ShowPassed()
    Scaleform.ShowWasted(_('terminate_won'), '', 5)
end

function Scaleform.ShowWasted(message, subMessage, secondsToShow)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.LoadScaleform('MP_BIG_MESSAGE_FREEMODE')

        BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
        PushScaleformMovieMethodParameterString(message)
        PushScaleformMovieMethodParameterString(subMessage)
        PushScaleformMovieMethodParameterInt(5)
        EndScaleformMovieMethod()

        Scaleform.Draw(scaleform, secondsToShow * 50, 0)
    end)
end

function Scaleform.ShowMessage(message, subMessage, secondsToShow)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.LoadScaleform('MIDSIZED_MESSAGE')

        BeginScaleformMovieMethod(scaleform, 'SHOW_MIDSIZED_MESSAGE')
        PushScaleformMovieMethodParameterString(message)
        PushScaleformMovieMethodParameterString(subMessage)
        EndScaleformMovieMethod()

        Scaleform.Draw(scaleform, secondsToShow * 50, 1)
    end)
end

function Scaleform.ShowAddTime(time)
    Scaleform.ShowCountdown(time, 30, 30, 255)
end

function Scaleform.ShowRemoveTime(time)
    Scaleform.ShowCountdown(time, 255, 30, 30)
end

function Scaleform.ShowCountdown(text, r, g, b)
    Citizen.CreateThread(function()
        local scaleform = Scaleform.LoadScaleform('COUNTDOWN')

        BeginScaleformMovieMethod(scaleform, 'SET_MESSAGE')
        PushScaleformMovieMethodParameterString(text)
        PushScaleformMovieMethodParameterInt(r)
        PushScaleformMovieMethodParameterInt(g)
        PushScaleformMovieMethodParameterInt(b)
        PushScaleformMovieMethodParameterBool(false)
        EndScaleformMovieMethod()

        Scaleform.Draw(scaleform, 40, 10)
    end)
end

function Scaleform.LoadScaleform(scaleformName)
    local scaleform = RequestScaleformMovie(scaleformName)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    return scaleform
end

function Scaleform.Draw(scaleform, loops, delayBetweenLoops)
    for i = 1, loops do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        Citizen.Wait(delayBetweenLoops)
    end
end