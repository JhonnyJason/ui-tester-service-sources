############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("testresultwritermodule")
#endregion

############################################################
import fs from 'fs'
import * as pth  from "path"

############################################################
import { resultsBasePath } from "./configmodule.js"
import * as utl from "./utilmodule.js"

############################################################
resultBaseAbsolute = ""

############################################################
preparedPaths = new Set()

############################################################
export initialize = ->
    log "initialize"
    if pth.isAbsolute(resultsBasePath) then resultBaseAbsolute = resultsBasePath
    else resultBaseAbsolute = pth.resolve(process.cwd(), resultsBasePath)
    return

############################################################
export prepareResultDir = (testName) ->
    log "prepareResultDir"
    resultDir = pth.resolve(resultBaseAbsolute, testName)
    assertUnprepared(resultDir)

    if utl.isDirectory(resultDir) or utl.isFile(resultDir) ## does exist
        fs.rmSync(resultDir, { recursive: true, force: true }) ##remove
    
    fs.mkdirSync(resultDir)

    preparedPaths.add(resultDir)
    return resultDir

############################################################
export writeSuccess = (resultPath) ->
    log "writeSuccess"
    readableTimestamp = new Date().toString()
    log readableTimestamp
    
    timestamp = readableTimestamp
    message = "All Steps finished without error :-)"
    obj = { timestamp, message }

    successFileString = JSON.stringify(obj, null, 4)
    successFilePath = pth.resolve(resultPath, "success.json")
    fs.writeFileSync(successFilePath, successFileString)
    return

export writeError = (resultPath, error) ->
    log "writeError"
    readableTimestamp = new Date().toString()
    log readableTimestamp
    
    timestamp = readableTimestamp
    message = error.message
    obj = { timestamp, message }

    errorFileString = JSON.stringify(obj, null, 4)
    errorFilePath = pth.resolve(resultPath, "error.json")
    fs.writeFileSync(errorFilePath, errorFileString )
    return

############################################################
assertUnprepared = (path) ->
    return unless preparedPaths.has(path)
    message = """
        We already prepared this path! #{path}
        This means you have multiple test-scripts with the same testName.
        Notice: That only the first test will be run and any further are ignored.
    """
    throw new Error(message)
