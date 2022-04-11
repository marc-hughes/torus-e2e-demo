// moodle.js created with Cypress

// Quick proof of concept of navigating from moodle to torus in a cypress test.
// Goes from a moodle trial account I made -> my ngrok address / local server

it("moodle-login", function () {
  /* ==== Generated with Cypress Studio ==== */
  cy.visit("https://marcdemo.moodlecloud.com/");
  cy.get("#username").clear();
  cy.get("#username").type(Cypress.env("moodle_username"));
  cy.get("#password").clear();
  cy.get("#password").type(Cypress.env("moodle_password"));
  cy.get(".rememberpass > label").click();
  cy.get("#rememberusername").check();
  cy.get("#loginbtn").click();
  cy.get(".multiline").click();

  cy.on("window:before:load", (win) => {
    cy.stub(win, "open").callsFake((url) => (win.location = url));
  });

  cy.get(".instancename").click();

  cy.get(".page-title")
    .contains("A Course Like No Other")
    .should("be.visible")
    .click();
});
