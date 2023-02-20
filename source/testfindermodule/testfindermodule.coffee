############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("testfindermodule")
#endregion

############################################################
import pathModule from "path"
import fs from "fs"

############################################################
import { testFilesPath } from "./configmodule.js"
import { isDirectory, isFile } from "./utilmodule.js"

############################################################
allTestPaths = []

############################################################
testFileEnding = ".mjs"

############################################################
export findAllTests = ->
    log "findAllTests"
    if pathModule.isAbsolute(testFilesPath) then baseAbsolute = testFilesPath
    else baseAbsolute = pathModule.resolve(process.cwd(), testFilesPath) 

    if !isDirectory(baseAbsolute) then throw new Error("Missing directory for test files! configured is: #{testFilesPath}\nAbsolute: #{baseAbsolute}")

    allTestPaths = findRelevantFiles(baseAbsolute)
    olog allTestPaths
    return allTestPaths

############################################################
#region internalFunctions

findRelevantFiles = (path) ->
    log "findRelevantFiles"
    allEntries = fs.readdirSync(path)
    allRelevant = []
    for entry in allEntries 
        entryAbsolute = pathModule.resolve(path, entry)
        if isRelevantFile(entryAbsolute) then allRelevant.push(entryAbsolute)
    return allRelevant

############################################################
isRelevantFile = (path) ->
    log "isRelevantFile"
    return false unless isFile(path)
    return false unless path.endsWith(testFileEnding)
    return true

#endregion
