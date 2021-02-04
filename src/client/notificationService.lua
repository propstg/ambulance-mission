NotificationService = {}

function NotificationService.ShowGameFailedMessage(reasonFailed)
    if Config.RpMode then
        NotificationService.ShowToastNotification(Wrapper._('terminate_failed_toast', reasonFailed))
    else
        Scaleform.ShowWasted(Wrapper._('terminate_failed_scale'), reasonFailed, 5)
    end
end

function NotificationService.ShowGameWonMessage()
    if Config.RpMode then
        NotificationService.ShowToastNotification(Wrapper._('terminate_won_toast'))
    else
        Scaleform.ShowPassed()
    end
end

function NotificationService.ShowMoneyAddedMessage(moneyAdded)
    if Config.RpMode then
        NotificationService.ShowToastNotification(Wrapper._('add_money_toast', moneyAdded))
    else
        Scaleform.ShowAddMoney(Wrapper._('add_money_scale', moneyAdded))
    end
end

function NotificationService.ShowReturnToHospitalMessage(reasonToReturn)
    if Config.RpMode then
        NotificationService.ShowToastNotification(Wrapper._('return_to_hospital_header_toast', reasonToReturn))
    else
        Scaleform.ShowMessage(Wrapper._('return_to_hospital_header_scale'), reasonToReturn, 5)
    end
end

function NotificationService.ShowAddTime(timeToAdd)
    if not Config.RpMode then
        Scaleform.ShowAddTime(Wrapper._('time_added', timeToAdd))
    end
end

function NotificationService.ShowRemoveTime(timeToAdd)
    if not Config.RpMode then
        Scaleform.ShowRemoveTime(Wrapper._('time_added', timeToAdd))
    end
end

function NotificationService.ShowLevelStartedMessage(level, formattedLevelMessageFragment)
    if Config.RpMode then
        NotificationService.ShowToastNotification(
            Wrapper._('start_level_header_toast', level, formattedLevelMessageFragment))
    else
        Scaleform.ShowMessage(Wrapper._('start_level_header_scale', level), formattedLevelMessageFragment, 5)
    end
end

function NotificationService.ShowToastNotification(message)
    ESX.ShowNotification(message)
end