describe('wrapper', function()

    before_each(function()
        _G.json = {encode = 'encode test'}

        require('../../src/lib/wrapper')
    end)

    it('manually set overrides are found', function()
        assert.equals(Wrapper.jsonEncode, 'encode test')
    end)

    it('looks up and returns global function when called', function()
        _G.SomeNative = function() return 'Some Value' end
        _G.SomeOtherNative = function() return 'Some Other Value' end

        assert.is_not_nil(Wrapper.print)
        assert.is_not_nil(Wrapper.SomeNative)
        assert.is_not_nil(Wrapper.SomeOtherNative)
        assert.equals('Some Value', Wrapper.SomeNative())
        assert.equals('Some Other Value', Wrapper.SomeOtherNative())
    end)
end)