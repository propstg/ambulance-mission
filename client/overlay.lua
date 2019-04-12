Overlay = {}
Overlay.isVisible = false
Overlay.gameData = {} -- {secondsLeft: xxx, pedsInAmbulance: {}, level: xxx}

function Overlay.Stop()
    Overlay.isVisible = false
    Overlay.SendMessage({
        type = 'changeVisibility',
        visible = false
    })
end

function Overlay.Start(gameData)
    Overlay.isVisible = true

    Overlay.Update(gameData)

    Overlay.SendMessage({
        type = 'changeVisibility',
        visible = true
    })
end

function Overlay.determineTimeLeft()
    if Overlay.gameData.secondsLeft == nil then
        return ''
    end

    local minutes = math.floor(Overlay.gameData.secondsLeft / 60)
    local seconds = math.floor(Overlay.gameData.secondsLeft - minutes * 60)
    local formattedTime = string.format('%02d:%02d', minutes, seconds)

    return _('overlay_time_left', formattedTime)
end

function Overlay.determineLevel()
    return Overlay.gameData.level
end

function Overlay.determineEmptySeats()
    if Overlay.gameData.pedsInAmbulance == nil then
        return ''
    end

    return Config.MaxPatientsPerTrip - #Overlay.gameData.pedsInAmbulance
end

function Overlay.determinePatientsLeft()
    if Overlay.gameData.peds == nil then
        return ''
    end

    return #Overlay.gameData.peds
end

function Overlay.Update(gameData)
    Overlay.gameData = gameData

    local data = {
        type = 'tick',
        timeLeft = Overlay.determineTimeLeft(),
        level = Overlay.determineLevel(),
        emptySeats = Overlay.determineEmptySeats(),
        patientsLeft = Overlay.determinePatientsLeft()
    }

    Overlay.SendMessage(data)
end

function Overlay.Init()
    Overlay.SendMessage({
        type = 'init',
        translatedLabels = Locales[Config.Locale]
    })
end

function Overlay.SendMessage(message)
    SendNuiMessage(json.encode(message))
end
