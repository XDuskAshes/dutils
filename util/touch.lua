local args = {...}
local util = {}
util.name = "touch"
util.description = "Simply create an empty file."
util.usage = util.name.." <file>\n "..util.name.." <file> <file> etc..."

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usage:\n "..util.usage)
else
    for k,v in pairs(args) do
            if fs.exists(shell.resolve(v)) then
                error("File or directory exists: "..v,0)
            else

            local handle = fs.open(shell.resolve(v),"w")
            if not handle then
                error("Error occured trying to make "..v..".",0)
            end
            handle.close()
        end
    end
end