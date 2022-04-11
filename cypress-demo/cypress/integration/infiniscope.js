// A quick proof of concept to prove we can navigate from infiniscope portal to our app.
// Goes from infiniscope staging -> torus QA

it("infiniscope page transition", function () {
  cy.visit("https://staging.infiniscope.org/lesson/41");
  cy.get(".img-fluid").click();
  cy.get(".login-form > :nth-child(1) > .form-control").clear();
  cy.get(".login-form > :nth-child(1) > .form-control").type(
    Cypress.env("infiniscope_username")
  );
  cy.get(":nth-child(2) > .form-control").clear();
  cy.get(":nth-child(2) > .form-control").type(
    Cypress.env("infiniscope_password")
  );
  cy.get(".btn-groups > .btn-blue").click();
  cy.get(".ng-dirty > .login-form > .row > .col-7 > span > a").click();
  cy.visit("https://staging.infiniscope.org/lesson/41");

  cy.on("window:before:load", (win) => {
    cy.stub(win, "open").callsFake((url) => (win.location = url));
  });

  cy.get(
    ":nth-child(1) > .learn-card > .learn-card-body > .learn-card-footer > .btn-blue"
  ).click();

  cy.get("iframe")
    .first()
    .then((recaptchaIframe) => {
      const body = recaptchaIframe.contents();
      // TODO - we need a tweak to the torus app so we can bypass the captchas during an automated test.
      cy.wrap(body)
        .find(".recaptcha-checkbox-border")
        .should("be.visible")
        .click();
    });

  cy.get("button").contains("Enroll as Guest").click();

  cy.get(".help-block")
    .contains("ReCaptcha failed, please try again")
    .should("be.visible");
});
