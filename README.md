# E2E demo / proof of concept

This repo contains 2 demos of testing a torus adaptive lesson.

See
[hound_demo/README.md](hound_demo/README.md)
[cypress-demo/README.md](cypress-demo/README.md)
for specific info on each demo

## TODO

In either solution, we've got a few things that need to be done, and possibly will require some figuring out.

- Data setup
- Where / When are we running these and where/when we want to report failures
  - After we get a handful of tests, we'll need a parellelization strategy to go with that
- Alter some of our elements with additional id or aria-label attributes to make them more discoverable. (aria-label may have the bonus of improving accessibility)

## Future considerations

After writing the test this way, it became apparent that there's a few common patterns these pages follow. If many lessons (like say, all the in spark lessons) follow
similar patterns, we can write some higher-level functions similar to `AdaptiveLessonPage.completeMCPage` and make these much more data-drive tests. It would probably
even be possible to write code that discovers the correct path through a lesson to aid in generating data files to drive those tests.

I don't know if we have any use of this, but using either solution, it would be possible to generate a series of screenshots showing off every single page for editorial /
review purposes.

## Comparison

Everyone loves a comparison table:

| Feature                               | Hound                                                                                                         | Cypress                                                                                                                                                                                        |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Language                              | Elixir                                                                                                        | Javascript / TypeScript                                                                                                                                                                        |
| Adaptive Lesson Testing               | Works                                                                                                         | Works                                                                                                                                                                                          |
| Live view testing                     | Works                                                                                                         | Works                                                                                                                                                                                          |
| Browser support                       | Chrome, Firefox, Edge, IE, Safari                                                                             | Chrome, Edge, Firefox                                                                                                                                                                          |
| Parallel test support                 | Yes                                                                                                           | Yes                                                                                                                                                                                            |
| Clustered test support                | With a selenium grid we roll or buy.                                                                          | Run docker containers w/ Dashboard orchestration                                                                                                                                               |
| Github Action                         | Roll our own? Some info here https://elixirforum.com/t/end-to-end-testing-with-hound-and-github-actions/28245 | https://github.com/cypress-io/github-action                                                                                                                                                    |
| Debug Output                          | Stack trace on failure, Screenshot of failure                                                                 | Screenshot of failure. Test & browser logs of failures. Video of run.                                                                                                                          |
| Other Features                        | Multiple Browser Sessions                                                                                     | [Plugins.](https://docs.cypress.io/plugins/directory) Mock HTTP responses. Development / debugging environment. Control browser date/time. Stub/Spy client code. Dashboard to track test runs. |
| Act like a user (Scrolling & waiting) | Manual                                                                                                        | Automatic                                                                                                                                                                                      |
| Trigger Manual Screenshots            | Yes                                                                                                           | Yes                                                                                                                                                                                            |
| Example Test Time                     | 1:31                                                                                                          | 1:18                                                                                                                                                                                           |
