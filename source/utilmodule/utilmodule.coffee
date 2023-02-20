############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("utilmodule")
#endregion

############################################################
import fs from "fs"

############################################################
export isDirectory = (path) ->
    try
        stat = fs.statSync(path)
        return stat.isDirectory()
    catch err
        ## probably does not exist
        return false

############################################################
export isFile = (path) ->
    try
        stat = fs.statSync(path)
        return stat.isFile()
    catch err
        ## probably does not exist
        return false
