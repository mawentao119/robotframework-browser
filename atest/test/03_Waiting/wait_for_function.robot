*** Settings ***
Resource          imports.resource
Suite Setup       Open Browser To No Page
Test Setup        New Page    ${LOGIN_URL}

*** Variables ***
${timeout_message}=    page.waitForFunction: Timeout 100ms exceeded.

*** Test Cases ***
Succesful Wait For Function
    Wait For Function    true    timeout=500ms

Failed Wait For Function
    Run Keyword and Expect Error    STARTS: ${timeout_message}    Wait For Function    false    timeout=100ms

Failed complicated Wait For Function
    Run Keyword And Expect Error    STARTS: ${timeout_message}    Wait For Function    (selector) => document.activeElement === selector    selector=\#username_field    timeout=100ms

Failed Wait For Function Promise
    ${promise}    Promise To    Wait For Function    (selector) => {console.log(selector); return document.activeElement === selector}    selector=\#username_field    timeout=100ms
    Run Keyword and Expect Error    STARTS: ${timeout_message}    Wait For    ${promise}

Succesful Wait For Function Promise
    ${promise}    Promise To    Wait For Function    (selector) => document.activeElement === selector    selector=\#username_field    timeout=500ms
    Click    \#username_field
    Wait For    ${promise}
