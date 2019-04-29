describe('stream', function()

    local INIT_TABLE

    setup(function()
        require('../../src/lib/stream')
    end)

    before_each(function()
        INIT_TABLE = {
            {
                Name = 'Name 1',
                SomeBoolean = true
            },{
                Name = 'Name 2',
                SomeBoolean = false
            },{
                Name = 'Name 3',
                SomeBoolean = true
            }
        }
    end)

    it('filter - does not fail when no elements', function()
        local values = Stream.of({})
            .filter(function(v, i) return false end)
            .collect()

        assert.equals(#values, 0)
    end)

    it('filter - all filtered', function()
        local values = Stream.of(INIT_TABLE)
            .filter(function(v, i) return false end)
            .collect()

        assert.equals(#values, 0)
    end)

    it('filter - none filtered', function()
        local values = Stream.of(INIT_TABLE)
            .filter(function(v, i) return true end)
            .collect()

        assert.equals(#values, 3)
        assert.equals(values[1].Name, 'Name 1')
        assert.equals(values[2].Name, 'Name 2')
        assert.equals(values[3].Name, 'Name 3')
    end)

    it('filter - some filtered', function()
        local values = Stream.of(INIT_TABLE)
            .filter(function(v, i) return v.SomeBoolean end)
            .collect()

        assert.equals(#values, 2)
        assert.equals(values[1].Name, 'Name 1')
        assert.equals(values[2].Name, 'Name 3')
    end)

    it('map - does not fail when no elements', function()
        local values = Stream.of({})
            .map(function(v, i) return v.Name end)
            .collect()

        assert.equals(#values, 0)
    end)

    it('map - successfully maps elements', function()
        local values = Stream.of(INIT_TABLE)
            .map(function(v, i) return v.Name end)
            .collect()

        assert.equals(#values, 3)
        assert.equals(values[1], 'Name 1')
        assert.equals(values[2], 'Name 2')
        assert.equals(values[3], 'Name 3')
    end)
    
    it('forEach - does not fail when no elements', function()
        local callCount = 0

        local values = Stream.of({})
            .forEach(function(v, i) callCount = callCount + 1 end)

        assert.equals(callCount, 0)
    end)

    it('forEach - called for every element', function()
        local callCount = 0

        local values = Stream.of(INIT_TABLE)
            .shuffle()
            .forEach(function(v, i) callCount = callCount + 1 end)

        assert.equals(callCount, 3)
    end)

    it('collect - does not fail when no elements', function()
        local values = Stream.of({}).collect()

        assert.equals(#values, 0)
    end)

    it('collect - has elements', function()
        local values = Stream.of(INIT_TABLE).collect()

        assert.equals(#values, 3)
    end)

    it('anyMatch - does not fail when no elements', function()
        local doAnyMatch = Stream.of({})
            .anyMatch(function(v, i) return not v.SomeBoolean end)

        assert.is_false(doAnyMatch)
    end)

    it('anyMatch - returns true when any element matches', function()
        local doAnyMatch = Stream.of(INIT_TABLE)
            .anyMatch(function(v, i) return not v.SomeBoolean end)

        assert.is_true(doAnyMatch)
    end)

    it('anyMatch - returns false when no elements match', function()
        local doAnyMatch = Stream.of(INIT_TABLE)
            .anyMatch(function(v, i) return v.Name == 'Name 4' end)

        assert.is_false(doAnyMatch)
    end)
end)