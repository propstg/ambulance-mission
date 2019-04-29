local mockagne = require 'mockagne'

describe('client - main', function()
    
    setup(function()
        _G.Wrapper = mockagne.getMock()
        _G.Citizen = mockagne.getMock()

        require('../../src/client/main')
    end)

    pending('TODO:  write tests for main')
end)