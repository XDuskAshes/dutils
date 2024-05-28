local args = {...}
local util = {}
util.name = "httpoke"
util.description = "Poke at a web address to see if it exists."
util.usage = util.name.." <address>"

if args[1] == "help" or args[1] == "--help" or #args < 1 then
    print(util.name.." | "..util.description)
    print("Usage:\n "..util.usage)
else
    local request, respMsg = http.get(args[1])
    if not request then
        printError("Caught an error sending a GET request to: "..args[1])
        print(respMsg)
    else
        print("Web address exists and is responsive: "..args[1])
        request.close()
    end
end