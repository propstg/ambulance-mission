Scaleform = {}

function Scaleform.ShowWasted(message, subMessage, secondsToShow)
    Citizen.CreateThread(function()
        local scaleform = RequestScaleformMovie('mp_big_message_freemode')
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end

        BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
        PushScaleformMovieMethodParameterString(message)
        PushScaleformMovieMethodParameterString(subMessage)
        PushScaleformMovieMethodParameterInt(5)
        EndScaleformMovieMethod()

        for i = 1, secondsToShow * 50 do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            Citizen.Wait(0)
        end
    end)
end

function Scaleform.ShowPassed()
    Scaleform.ShowWasted(_('terminate_won'), '', 5)
end

function Scaleform.ShowMessage(message, subMessage, secondsToShow)
    Citizen.CreateThread(function()
        local scaleform = RequestScaleformMovie('MIDSIZED_MESSAGE')
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(1)
        end

        BeginScaleformMovieMethod(scaleform, 'SHOW_MIDSIZED_MESSAGE')
        PushScaleformMovieMethodParameterString(message)
        PushScaleformMovieMethodParameterString(subMessage)
        EndScaleformMovieMethod()

        for i = 1, secondsToShow * 50 do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            Citizen.Wait(1)
        end
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
        local scaleform = RequestScaleformMovie('COUNTDOWN')
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end

        BeginScaleformMovieMethod(scaleform, 'SET_MESSAGE')
        PushScaleformMovieMethodParameterString(text)
        PushScaleformMovieMethodParameterInt(r)
        PushScaleformMovieMethodParameterInt(g)
        PushScaleformMovieMethodParameterInt(b)
        PushScaleformMovieMethodParameterBool(false)
        EndScaleformMovieMethod()

        for i = 1, 40 do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            Citizen.Wait(10)
        end
    end)
end
