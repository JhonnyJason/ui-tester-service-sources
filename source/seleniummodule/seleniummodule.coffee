############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("seleniummodule")
#endregion


############################################################
import { Builder, By, Key } from "selenium-webdriver"
import firefox from "selenium-webdriver/firefox"

import chai from 'chai'
import chaiWebdriver from 'chai-webdriver'

import { writeFile, readdir } from 'node:fs/promises'
import { resolve } from "path"

# geckodriverPath = "../geckodriver/target/release"
# geckodriverPath = "geckodriver"

############################################################
# servive = null
browser = null

############################################################
export initialize = ->
    log "initialize"
    return
    # service = await new firefox.ServiceBuilder(geckodriverPath)
    browser = await new Builder().forBrowser('firefox').build()
    await browser.manage().window().maximize() 
    await browser.manage().setTimeouts( { implicit: 1000 } )
    chai.use(chaiWebdriver(browser))

    transitionTime = -> await waitMS(1000)
    
    testFilePath = resolve(process.cwd(), 'openmenu.mjs')
    { testName, run } = await import(### webpackIgnore: true ###testFilePath)
    
    takeScreenshot = (num) -> await saveScreenshot(browser, "#{testName}-step#{num}")
    
    
    browserUtils = { browser, By, Key}
    resultUtils = { chai, transitionTime, takeScreenshot}
    try 
        await run(browserUtils, resultUtils)
        log "success!"
    catch err
        log "fail!" 
        log err
        

    
    ## Sample test

    return
    # ## Navigate to url
    # await driver.get('https://secrets-cockpit.extensivlyon.coffee');

    # settingsButton = await driver.findElement(By.id("header-right"))
    # await settingsButton.click()
    # await waitMS(500) # wait for transition to finish

    # ## Take screenshot        
    # await saveScreenshot(driver, "open_menu_step1")  

    # backButton = await driver.findElement(By.css(".active > .slideinframe-back-button"))
    # await backButton.click()
    # await waitMS(500) # wait for transition to finish

    # ## Take screenshot        
    # await saveScreenshot(driver, "open_menu_step2")  

    # await driver.quit()
    # return

############################################################
waitMS = (timeMS)->
    return new Promise (resolve, reject) ->
        setTimeout(resolve, timeMS)

############################################################
saveScreenshot = (browser, filename) ->
    if !filename.endsWith(".png") then filename += ".png" 
    image = await browser.takeScreenshot()
    await writeFile(filename, image, 'base64')
    return
