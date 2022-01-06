*** Settings ***
Resource    ../Pages/InscriptionPage.robot
Resource    ../Pages/InscriptionEspace.robot
Resource    ../Pages/Login page.robot
Resource    ../Pages/Home Page.robot
Resource    ../Pages/Comptes.robot
Library    String                    
*** Test Cases ***
Test    

    # DISABLE DEFAULT CAPTURE IF FAILED, SET CAPTURE WITH GOOD FILENAME IN TEARDOWN
    SeleniumLibrary.Register Keyword To Run On Failure    NONE
    # SET CHROME BINARY
    # SET CHROME OPTIONS
    ${options}=    BuiltIn.Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --test-type
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --ignore-certificate-errors
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    # AUTOMATICALY DEFAULT DOWNLOAD DIRECTORY
	${prefs}    Create Dictionary    download.default_directory=${OUTPUT DIR}    profile.default_content_settings.popups=${0}    profile.default_content_setting_values.notifications=${2}
	Call Method    ${options}    add_experimental_option    prefs    ${prefs}  
	# DISABLE POPUP CHROME CONTROLED BY AUTOMATION TOOLS
	Call Method    ${options}    add_experimental_option    useAutomationExtension    ${False}
    ${excluded}    Create List    enable-automation
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${excluded}
    # SET CHROME PORTABLE BINARY
    # START DRIVER
    SeleniumLibrary.Create Webdriver    Chrome    chrome_options=${options}     
    SeleniumLibrary.Maximize Browser Window 

	Set Selenium Speed    0.1s
	Go To   https://www.google.com