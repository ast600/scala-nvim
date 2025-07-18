local module = {}

function module:setup()
    local dap = require('dap')
    dap.configurations.scala = {
        {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {runType = "runOrTestFile"}
        }, {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {runType = "testTarget"}
        }
    }
end

return module
