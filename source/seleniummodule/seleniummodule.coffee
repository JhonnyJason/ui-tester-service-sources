############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("seleniummodule")
#endregion


############################################################
import { Builder } from "selenium-webdriver"
import firefox from "selenium-webdriver/firefox"

geckodriverPath = "../geckodriver/target/release"

############################################################
servive = null
driver = null

############################################################
export initialize = ->
    log "initialize"
    service = new firefox.ServiceBuilder(geckodriverPath)
    driver = new Builder().forBrowser('firefox').setChromeService(service).build()

    return