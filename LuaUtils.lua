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

PowerCommuter.LuaUtils = LuaUtils