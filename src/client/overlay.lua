Overlay = {}
Overlay.isVisible = false
Overlay.wasPaused = false
Overlay.gameData = {
    secondsLeft = 0,
    level = 0,
    peds = {},
    pedsInAmbulance = {}
}

function Overlay.Init()
    Overlay.SendMessage({
        type = 'init',
        translatedLabels = Locales[Config.Locale]
    })
end

function Overlay.Stop()
    Overlay.isVisible = false
    Overlay.wasPaused = false
    Overlay.SendChangeVisibilityMessage(false)
end

function Overlay.Start(gameData)
    Overlay.isVisible = true

    Overlay.Update(gameData)
    Overlay.SendChangeVisibilityMessage(true)

    Citizen.CreateThread(function()
        while Overlay.isVisible do
            Citizen.Wait(250)

            local isPaused = Wrapper.IsPauseMenuActive()

            if isPaused ~= Overlay.wasPaused then
                Overlay.SendChangeVisibilityMessage(not isPaused)
                Overlay.wasPaused = isPaused
            end
        end
    end)
end

function Overlay.Update(gameData)
    Overlay.gameData = gameData

    local data = {
        type = 'tick',
        timeLeft = Overlay.determineTimeLeft(),
        level = Overlay.gameData.level,
        emptySeats = Config.MaxPatientsPerTrip - #Overlay.gameData.pedsInAmbulance,
        patientsLeft = #Overlay.gameData.peds
    }

    Overlay.SendMessage(data)
end

function Overlay.determineTimeLeft()
    local minutes = math.floor(Overlay.gameData.secondsLeft / 60)
    local seconds = math.floor(Overlay.gameData.secondsLeft - minutes * 60)
    return string.format('%02d:%02d', minutes, seconds)
end

function Overlay.SendChangeVisibilityMessage(visible)
    Overlay.SendMessage({
        type = 'changeVisibility',
        visible = visible
    })
end

function Overlay.SendMessage(message)
    Wrapper.SendNuiMessage(Wrapper.jsonEncode(message))
end