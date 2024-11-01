*** Settings ***
Documentation  Simple example using AppiumLibrary
Library  AppiumLibrary

*** Variables ***
${ANDROID_AUTOMATION_NAME}    UiAutomator2
${ANDROID_APP}                ${CURDIR}/../demoapp/dialogqa-prod.apk
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=12}

*** Test Cases ***
Acess de app and verify login
    Open Test Application
    Accept cookies if present
    Login in app if present
    Accept notifications if present
    Close password if present
#    Navigate in pages

*** Keywords ***
Open Test Application
  Open Application  http://127.0.0.1:4723/wd/hub  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
  ...  app=${ANDROID_APP}  appPackage=br.com.dialog.dialogqa  

Accept cookies if present
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    //android.widget.Button[@text="Accept cookies"]    10s
    Run Keyword If    ${result}    Click Element    xpath=//android.widget.Button[@text="Accept cookies"]   
    ...    ELSE    Log    Cookies not found 

Login in app if present
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    //android.widget.Button[@text="Entrar"]    15s
    Run Keyword If    ${result}    Login in app     
    ...    ELSE    Log    Login is not necessary

Login in app
    Input Text   //(//android.webkit.WebView[@text="DialogQA"]//android.widget.EditText)[1]    {{username}} 
    Input Text   //(//android.webkit.WebView[@text="DialogQA"]//android.widget.EditText)[2]    {{passwaord}} 
    Click Element    //android.widget.Button[@text="Entrar"]

Accept notifications if present
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=com.android.chrome:id/text    5s
    Run Keyword If    ${result}    Click Element    id=com.android.chrome:id/positive_button   
    ...    ELSE    Log    Notifications not found

Close password if present
    ${result}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=com.android.chrome:id/infobar_message    3s
    Run Keyword If    ${result}    Click Element    id=com.android.chrome:id/button_secondary   
    ...    ELSE    Log    Save password not found
