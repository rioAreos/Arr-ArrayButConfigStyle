function initialize()
    local Arr = {}

    local storage = {}
    local metadata = {}

    function Arr.arrayCreate(config)
        if not config or not config.name then
            error("Array must have a name")
        end

        local name = config.name
        local values = config.value or {}
        local expectedType = config.type
        local maxSize = config.itemsize
        local deleteExceeds = config.deleteExceeds or false
        local showIndex = config.showIndex or false

        -- validate initial values
        if expectedType then
            for i, v in ipairs(values) do
                if type(v) ~= expectedType then
                    error("Type mismatch in array '" .. name .. "' at index " .. i)
                end
            end
        end

        if maxSize and #values > maxSize then
            if deleteExceeds then
                while #values > maxSize do
                    table.remove(values)
                end
            else
                error("Array '" .. name .. "' exceeds max size")
            end
        end

        storage[name] = values

        metadata[name] = {
            type = expectedType,
            itemsize = maxSize,
            deleteExceeds = deleteExceeds,
            showIndex = showIndex
        }

        -- proxy with enforcement
        Arr[name] = setmetatable({}, {
            __index = function(_, key)
                local arr = storage[name]

                -- RANDOM PICK
                if key == "rand" then
                    if #arr == 0 then return nil end
                    local i = math.random(1, #arr)
                    local value = arr[i]

                    if metadata[name].showIndex then
                        return value .. " - index of " .. i
                    end

                    return value
                end

                local value = arr[key]

                if metadata[name].showIndex and value ~= nil then
                    return value .. " - index of " .. key
                end

                return value
            end,

            __newindex = function(_, key, value)
                local arr = storage[name]
                local meta = metadata[name]

                -- type enforcement
                if meta.type and type(value) ~= meta.type then
                    error("Type mismatch: expected " .. meta.type .. ", got " .. type(value))
                end

                -- size enforcement
                if meta.itemsize and key > meta.itemsize then
                    if meta.deleteExceeds then
                        return -- ignore insertion
                    else
                        error("Array '" .. name .. "' exceeded max size")
                    end
                end

                arr[key] = value
            end
        })
    end

    return Arr
end

local loader = require("Task")
Arr = initialize()

Arr.arrayCreate({
  name = "school",
  type = "string",
  deleteExceeds = false,
  showIndex = true,
  value = {"students", "principal", "teacher", "school owner"}
})

print(Arr.school["rand"])