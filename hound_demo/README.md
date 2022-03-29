# Hound demo for testing an Oli Torus Adaptive lesson

## Installation

`mix deps.get`

Then choose and install a webdriver to run the tests with, we'll use chromedriver here, but selenium
might be a good choice too. PhantomJS probably isn't a good choice.

### Chromedriver

This assumes you have chrome installed already. Download a version appropriate for your system & chrome version from:

https://chromedriver.chromium.org/downloads

Unzip it and put it somewhere convienent.

### Config

See config/test.exs and supply any neccessary secrets such as `gas_student_password` found in System.get_env calls

## Running tests

First, start an instance of chromedriver

`./chromedriver`

Leave that running and run the tests

`mix test`

## Quick tour

Main test script in:  
`test/integration/gas_laws_test.exs`

Page object helpers in:  
`test/integration/pages`

Configuration in:  
`config/test.exs`

## Selector notes

To see inside a web component...

This works to see a span:
`"//janus-mcq//span"`

But this _does not_ work to query for a specific span containing text:
`"//janus-mcq//span[contains(text(), 'No')]"`

You can search for attributes of elements inside web components `"//label[@for='Begin-item-0']"`

Helpful Reference: https://devhints.io/xpath
