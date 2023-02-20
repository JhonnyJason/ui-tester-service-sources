import { addModulesToDebug } from "thingy-debug"

############################################################
export modulesToDebug = {

    seleniummodule: true
    startupmodule: true
    testfindermodule: true
    testresultwritermodule: true
    testrunnermodule: true
}
    
addModulesToDebug(modulesToDebug)