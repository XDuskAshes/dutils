local args = {...}
local util = {}
util.name = "cat"
util.description = "Concatenate files to terminal."
util.usage = util.name.." <file>"

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usage:\n "..util.usage)
else
    local handle = fs.open(shell.resolve(args[1]),"r")

    if not handle then
        error("Cannot find file: "..args[1])
    end

    print(handle.readAll())
    handle.close()
end