NewRef = function (id) 
    local _0x234423 = {}

    _0x234423.id    = id
    _0x234423.state = false

    _0x234423.GetId = function()
        return _0x234423.id
    end

    _0x234423.GetState = function()
        return _0x234423.state
    end

    _0x234423.ToggleRef = function()
        _0x234423.state = not _0x234423.state
    end

    return _0x234423
end