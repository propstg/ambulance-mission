local mockagne = require 'mockagne'

describe('client - scaleform', function()
    
    setup(function()
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = mockagne.getMock()

        require('../../src/client/scaleform')
    end)

    pending('TODO:  write tests for scaleform')
end)