############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("seleniummodule")
#endregion


############################################################
import { Builder, By } from "selenium-webdriver"
import firefox from "selenium-webdriver/firefox"
import { writeFile } from 'node:fs/promises'

# geckodriverPath = "../geckodriver/target/release"
# geckodriverPath = "geckodriver"

############################################################
# servive = null
driver = null

############################################################
export initialize = ->
    log "initialize"
    # service = await new firefox.ServiceBuilder(geckodriverPath)
    driver = await new Builder().forBrowser('firefox').build()
    await driver.manage().window().maximize() 
    await driver.manage().setTimeouts( { implicit: 1000 } )



    ## Sample test
    
    ## Navigate to url
    await driver.get('https://secrets-cockpit.extensivlyon.coffee');

    settingsButton = await driver.findElement(By.id("header-right"))
    await settingsButton.click()
    await waitMS(500) # wait for transition to finish

    ## Take screenshot        
    await saveScreenshot(driver, "open_menu_step1")  

    backButton = await driver.findElement(By.css(".active > .slideinframe-back-button"))
    await backButton.click()
    await waitMS(500) # wait for transition to finish

    ## Take screenshot        
    await saveScreenshot(driver, "open_menu_step2")  

    await driver.quit()
    return

############################################################
waitMS = (timeMS)->
    return new Promise (resolve, reject) ->
        setTimeout(resolve, timeMS)

############################################################
saveScreenshot = (driver, filename) ->
    if !filename.endsWith(".png") then filename += ".png" 
    image = await driver.takeScreenshot()
    await writeFile(filename, image, 'base64')
    return