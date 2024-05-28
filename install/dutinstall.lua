local list = http.get("https://raw.githubusercontent.com/XDuskAshes/dutils/master/install/list.json")

if not list then
    error("Can't find list.json in dutils repo, are you connected to the internet or is Github blacklisted?",0)
end

local data = textutils.unserialiseJSON(list.readAll())
list.close()

local utildir = "/util/"
local startup = true

local function allspace(str)
    return str:match("^%s*$") ~= nil
end


print("Type a directory to install utilities to.\nDefault: "..utildir)
write("> ")
utildir = read()
if allspace(utildir) then
    printError("Provided nothing, creating /util/ for installations.")
    utildir = "/util/"
end
write("Add a /startup.lua file to set path on each startup? [Y/N] ")
while true do
    local event = {os.pullEvent()}
    local nEvent = event[1]
    local vEvent = event[2]

    if nEvent == "key" then
        if vEvent == keys.y then
            print("y")
            break
        elseif vEvent == keys.n then
            print("n")
            startup = false
            break
        end
    end
end

if not fs.exists(utildir) then
    fs.makeDir(utildir)
end

print("Starting installation.")

for k,v in pairs(data.utils) do
    write("Installing "..k.."...")

    local handle = http.get(data.url..v)
    if not handle then
        error("Cannot get: "..data.url..v)
    end
    local fullFile = handle.readAll()
    handle.close()

    local utilHandle = fs.open(shell.resolve(utildir..v),"w")
    utilHandle.write(fullFile)
    utilHandle.close()

    print("done")
end

if startup then
    write("Making startup...")
    local handle = fs.open("/startup.lua","w")
    handle.write("local oPath = shell.path()\nshell.setPath(oPath..':"..utildir.."')")
    handle.close()
    print("done")
    shell.run("/startup.lua")
end