## TODO

The big part missing in this demo is the data-setup. You'll need a
student user account enrolled in a course with a "Gas Laws" unit
that's previously been started. It'll probably be best to create
some special-purpose API's for setting up the data for the tests.

## Setup

You can create a cypress.env.json to override config vars in cypress.json
that looks something like this:

```
{
  "host": "https://localhost:8043",
  "gas_student_username": "e2e-student@argos.education",
  "gas_student_password": "THEPASSWORDHERE"
}
```

Then, an `npm install` should get you up and running.

## Running the tests

To run the demo test:
`npm run test`

Afterwards, if your system has ffmpeg, you can watch the run from the video file
that gets generated `cypress/video/gas_laws_spec.mp4`
I'm leaving one of those in git in case you want to go see an example, but in a real-world
scenario we'd .gitignore them

To open up the cypress UI for development & debugging:
`npm run open`

## Quick tour

The actual test file lives at:  
`./cypress/integration/gas_laws_spec.ts`

There are various page-object helpers that it calls at:  
`./cypress/page/...`

Configuration info in:  
`./cypress.json`

Pretty much everything else here is just boilerplate cypress.

## Dashboard support

For recording test results, viewing videos/screenshots/logs, tracking test failures, flakey tests, or durations over time.

Test run dashboard: https://cypress.io
Open source alternative dashboard: https://sorry-cypress.dev/
