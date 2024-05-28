local args = {...}
local util = {}
util.name = "pa"
util.description = "Displays path attributes."
util.usage = util.name.." <path>"

local function getAttr(path)
    if fs.exists(path) then
        local attributes = fs.attributes(path)
        attributes.modification = nil
        return attributes
    else
        return nil, "File not found: "..path
    end
end

local function convUnixMillis(millis)
    -- Convert milliseconds to seconds
    local unixSeconds = millis / 1000

    -- Format the date string
    local dateTable = os.date("*t", unixSeconds)
    local formattedDate = string.format("%04d-%02d-%02d %02d:%02d:%02d",
                                        dateTable.year, dateTable.month, dateTable.day,
                                        dateTable.hour, dateTable.min, dateTable.sec)
    return formattedDate
end

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usages:\n "..util.usage)
else
    local attr,err = getAttr(shell.resolve(args[1]))
    if not attr then
        error(err,0)
    end

    local readableAttr = {
        size = "Size (bytes)",
        isDir = "Is Directory",
        isReadOnly = "Is Read-Only",
        created = "Creation Time",
        modified = "Last Modified"
    }
    
    for k, v in pairs(attr) do
        if not (attr.isDir and k == "size") then
            local description = readableAttr[k] or k
            if k == "created" or k == "modified" then
                v = convUnixMillis(v)
            end
            print(description..":", v)
        end
    end
end