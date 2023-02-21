############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("startupmodule")
#endregion


############################################################
import { findAllTests } from "./testfindermodule.js"
import { runAllTests } from "./testrunnermodule.js"

############################################################
export serviceStartup = ->
    log "startup"
    try
        allTests = await findAllTests()
        await runAllTests(allTests)
    catch err 
        log err 
        process.exit(-1)
    return
