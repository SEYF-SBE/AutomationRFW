*** Settings ***

Suite Setup         Before Each Test Suite
Suite Teardown      After Each Test Suite

*** Variables ***

*** Keywords ***

Before Each Test Suite
    Log To Console    Test Suite Started

After Each Test Suite
    Log To Console    Test Suite Ended