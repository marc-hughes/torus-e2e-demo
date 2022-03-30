# E2E demo / proof of concept

See hound-demo/README.md cypress-demo/README.md for specific info on each

# Comparison

Everyone loves a comparison table:

| Feature                               | Hound                                                                                                         | Cypress                                                                                                                                  |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Language                              | Elixir                                                                                                        | Javascript / TypeScript                                                                                                                  |
| Adaptive Lesson Testing               | Works                                                                                                         | Works                                                                                                                                    |
| Live view testing                     | Works                                                                                                         | Works                                                                                                                                    |
| Multi-Browser support                 | Chrome, Firefox, Edge, IE, Safari                                                                             | Chrome, Edge, Firefox                                                                                                                    |
| Parallel test support                 | Yes                                                                                                           | Yes                                                                                                                                      |
| Github Action                         | Roll our own? Some info here https://elixirforum.com/t/end-to-end-testing-with-hound-and-github-actions/28245 | https://github.com/cypress-io/github-action                                                                                              |
| Clustered test support                | No / roll our own                                                                                             | Yes                                                                                                                                      |
| Debug Output                          | Stack trace on failure (Screenshot of failure should be possible)                                             | Screenshot of failure. Test & browser logs of failures. Video of run.                                                                    |
| Other Features                        |                                                                                                               | Mock HTTP responses. Development / debugging environment. Control browser date/time. Stub/Spy client code. Dashboard to track test runs. |
| Act like a user (Scrolling & waiting) | Manual                                                                                                        | Automatic                                                                                                                                |
| Trigger Manual Screenshots            | Yes                                                                                                           | Yes                                                                                                                                      |
| Example Test Time                     | 1:31                                                                                                          | 1:18                                                                                                                                     |
