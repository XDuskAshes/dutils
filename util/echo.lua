local args = {...}
local util = {}
util.name = "echo"
util.description = "Repeat what's given"
util.usage = util.name.." <arg1> <arg2> etc..."

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usage:\n "..util.usage)
else
    local echoed = ""
    for k,v in pairs(args) do
        echoed = echoed..v.." "
    end
    print(echoed)
    return echoed
end