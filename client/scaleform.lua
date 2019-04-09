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

        for i = 1, secondsToShow / 1000 do
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
            Citizen.Wait(1)
        end
    )
end