local args = {...}
local util = {}
util.name = "head"
util.description = "Read the top of files."
util.usage = util.name.." <file>\n "..util.name.." <file> -n <number>\nBy default, head reads the first 15 lines."

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usage:\n "..util.usage)
else
    local path = shell.resolve(args[1])
    local lines = 15
    if fs.exists(path) then
        if #args > 1 then
            if args[2] == "-n" then
                lines = args[3]
            end
        end

        local handle = fs.open(path,"r")
        for i = 1, lines do
            print(handle.readLine())
        end
        handle.close()
    else
        error("Cannot find: "..args[1],0)
    end
end