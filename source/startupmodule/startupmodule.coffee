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
    allTests = await findAllTests()
    await runAllTests(allTests)
    return
