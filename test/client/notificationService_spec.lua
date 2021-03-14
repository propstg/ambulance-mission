local mockagne = require 'mockagne'
local when = mockagne.when
local any = mockagne.any
local verify = mockagne.verify
local verifyNoCall = mockagne.verify_no_call

describe('NotificationService', function()
    before_each(function()
        _G.Config = {}
        _G.Scaleform = mockagne.getMock()
        _G.Wrapper = mockagne.getMock()
        _G.ESX = mockagne.getMock()

        require('../../src/client/notificationService')
    end)

    describe('ShowGameFailedMessage', function()
        before_each(function()
            when(_G.Wrapper._('terminate_failed_toast', 'test reason')).thenAnswer('test failed toast')
            when(_G.Wrapper._('terminate_failed_scale')).thenAnswer('test failed scale')
        end)

        it('should show toast notification when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowGameFailedMessage('test reason')

            verifyNoCall(_G.Scaleform.ShowWasted(any(), any(), any()))
            verify(_G.ESX.ShowNotification('test failed toast'))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowGameFailedMessage('test reason')

            verify(_G.Scaleform.ShowWasted('test failed scale', 'test reason', 5))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowGameWonMessage', function()
        before_each(function()
            when(_G.Wrapper._('terminate_won_toast')).thenAnswer('test won toast')
        end)

        it('should show toast notification when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowGameWonMessage()

            verifyNoCall(_G.Scaleform.ShowPassed())
            verify(_G.ESX.ShowNotification('test won toast'))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowGameWonMessage()

            verify(_G.Scaleform.ShowPassed())
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowMoneyAddedMessage', function()
        before_each(function()
            when(_G.Wrapper._('add_money_toast', any())).thenAnswer('test add money toast')
            when(_G.Wrapper._('add_money_scale', any())).thenAnswer('test add money scale')
        end)

        it('should show toast notification when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowMoneyAddedMessage(15)

            verifyNoCall(_G.Scaleform.ShowAddMoney(any()))
            verify(_G.ESX.ShowNotification('test add money toast'))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowMoneyAddedMessage(15)

            verify(_G.Scaleform.ShowAddMoney('test add money scale'))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowReturnToHospitalMessage', function()
        before_each(function()
            when(_G.Wrapper._('return_to_hospital_header_toast', any())).thenAnswer('test return toast')
            when(_G.Wrapper._('return_to_hospital_header_scale')).thenAnswer('test return scale')
        end)

        it('should show toast notification when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowReturnToHospitalMessage('reason')

            verifyNoCall(_G.Scaleform.ShowMessage(any(), any(), any()))
            verify(_G.ESX.ShowNotification('test return toast'))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowReturnToHospitalMessage('reason')

            verify(_G.Scaleform.ShowMessage('test return scale', 'reason', 5))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowAddTime', function()
        before_each(function()
            when(_G.Wrapper._('time_added', any())).thenAnswer('test time added')
        end)

        it('should not show scaleform when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowAddTime(5)

            verifyNoCall(_G.Scaleform.ShowAddTime(any()))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowAddTime(5)

            verify(_G.Scaleform.ShowAddTime('test time added'))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowRemoveTime', function()
        before_each(function()
            when(_G.Wrapper._('time_added', any())).thenAnswer('test time added')
        end)

        it('should not show scaleform when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowRemoveTime(5)

            verifyNoCall(_G.Scaleform.ShowAddTime(any()))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowRemoveTime(5)

            verify(_G.Scaleform.ShowRemoveTime('test time added'))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowContinuousLevelStartedMessage', function()
        before_each(function()
            when(_G.Wrapper._('start_level_header_toast', any(), any())).thenAnswer('test level header toast')
            when(_G.Wrapper._('start_level_header_scale', any())).thenAnswer('test level header scale')
            when(_G.Wrapper._('start_level_sub_one')).thenAnswer('pick up patient')
        end)

        it('should show toast when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowContinuousLevelStartedMessage()

            verifyNoCall(_G.Scaleform.ShowMessage(any(), any(), any()))
            verify(_G.ESX.ShowNotification('pick up patient'))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowContinuousLevelStartedMessage()

            verify(_G.Scaleform.ShowMessage('test level header scale', 'message fragment', 5))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)

    describe('ShowLevelStartedMessage', function()
        before_each(function()
            when(_G.Wrapper._('start_level_header_toast', any(), any())).thenAnswer('test level header toast')
            when(_G.Wrapper._('start_level_header_scale', any())).thenAnswer('test level header scale')
        end)

        it('should show toast when Config.RpMode is true', function()
            _G.Config.RpMode = true

            NotificationService.ShowLevelStartedMessage(3, 'message fragment')

            verifyNoCall(_G.Scaleform.ShowMessage(any(), any(), any()))
            verify(_G.ESX.ShowNotification('test level header toast'))
        end)

        it('should show scaleform when not Config.RpMode is false', function()
            _G.Config.RpMode = false

            NotificationService.ShowLevelStartedMessage(3, 'message fragment')

            verify(_G.Scaleform.ShowMessage('test level header scale', 'message fragment', 5))
            verifyNoCall(_G.ESX.ShowNotification(any()))
        end)
    end)
end)