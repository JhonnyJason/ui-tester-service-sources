############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("seleniummodule")
#endregion

############################################################
import { writeFile } from 'node:fs/promises'

import { Builder, By, Key } from "selenium-webdriver"
import firefox from "selenium-webdriver/firefox"

import chai from 'chai'
import chaiWebdriver from 'chai-webdriver'

############################################################
import *  as utl from "./utilmodule.js"

############################################################
export getUtilitiesForTest = (resultPath) ->
    log "getUtilitiesForTest"
    browser = await new Builder().forBrowser('firefox').build()
    await browser.manage().window().maximize() 
    await browser.manage().setTimeouts( { implicit: 1000 } )
    chai.use(chaiWebdriver(browser))

    transitionTime = -> await utl.waitMS(1000)
    takeScreenshot = (num) -> await saveScreenshot(browser, "#{resultPath}/step#{num}")

    browserUtils = { browser, By, Key }
    resultUtils = { chai, transitionTime, takeScreenshot}
    return { browserUtils, resultUtils }


############################################################
saveScreenshot = (browser, filename) ->
    if !filename.endsWith(".png") then filename += ".png" 
    image = await browser.takeScreenshot()
    await writeFile(filename, image, 'base64')
    return
