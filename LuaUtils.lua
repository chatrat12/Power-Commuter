local LuaUtils = {}

function LuaUtils.TableConcat(t1, t2)
    for i=1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function LuaUtils.Where(table, condition)
    local result = {}
    for i, entry in ipairs(table) do
        if condition(entry) then
            table.insert(result, entry)
        end
    end
    return result
end

function LuaUtils.Count(table, condition)
    local result = 0
    for i, entry in ipairs(table) do
        if condition(entry) then
            result = result + 1
        end
    end
    return result
end

function LuaUtils.SPairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

PowerCommuter.LuaUtils = LuaUtils