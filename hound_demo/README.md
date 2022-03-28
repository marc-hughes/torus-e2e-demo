# Hound demo for testing an Oli Torus Adaptive lesson

## Installation

`mix deps.get`

Then choose and install a webdriver to run the tests with, we'll use chromedriver here, but selenium
might be a good choice too.

### Chromedriver

This assumes you have chrome installed already. Download a version appropriate for your system & chrome version from:

https://chromedriver.chromium.org/downloads

Unzip it and put it somewhere convienent.

## Running tests

First, start an instance of chromedriver

`./chromedriver`

Leave that running and run the tests

`mix test`
