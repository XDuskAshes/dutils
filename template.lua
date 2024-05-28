local args = {...}
local util = {}
util.name = "Template"
util.description = "Template for Dusk's Utils"
util.usage = util.name.." <args>"

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usage:\n "..util.usage)
else
    print("No help passed")
end