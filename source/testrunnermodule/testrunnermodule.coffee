############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("testrunnermodule")
#endregion

############################################################
export initialize = ->
    log "initialize"
    #Implement or Remove :-)
    return

############################################################
export runAllTests = (testPaths) ->
    log "runAllTests"
    olog {testPaths}
    return

