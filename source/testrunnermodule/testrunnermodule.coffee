############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("testrunnermodule")
#endregion

############################################################
import * as resultWriter from "./testresultwritermodule.js"
import * as selenium from "./seleniummodule.js"
import * as utl from "./utilmodule.js"

############################################################
export runAllTests = (testPaths) ->
    log "runAllTests"
    olog {testPaths}
    
    # run all tests sequencially - we could do parallel, maybe...
    for path in testPaths
        try await runTest(path)
        catch err then log err 
    
    return

############################################################
runTest = (path) ->
    log "runTest"
    { testName, run } = await import(### webpackIgnore: true ###path)
    resultPath = resultWriter.prepareResultDir(testName)
    olog { testName }
    olog {resultPath}

    { browserUtils, resultUtils } = await selenium.getUtilitiesForTest(resultPath)
    
    try 
        await run(browserUtils, resultUtils)
        log "success!"
        resultWriter.writeSuccess(resultPath)
    catch err
        log "fail!" 
        log err
        resultWriter.writeError(resultPath, err)
    # finally
    #     try
    #         await browserUtils.browser.quit()
    #         await utl.waitMS(500)
    #     catch err then log err
    return



