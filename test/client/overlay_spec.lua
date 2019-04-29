local mockagne = require 'mockagne'

describe('client - overlay', function()
    
    setup(function()
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = mockagne.getMock()

        require('../../src/client/overlay')
    end)

    pending('TODO:  write tests for overlay')
end)