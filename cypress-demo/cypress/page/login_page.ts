export const closeCookieDialog = () => {
  cy.get(".modal-content > .modal-footer > .btn-primary").should(
    "have.text",
    "Accept"
  );
}

export const goToEducatorLogin = () => {
  // TODO - be a lot better for these to have explicit id attributes than these wonky css path
  cy.get(".modal-content > .modal-footer > .btn-primary").click();
  cy.get(".container > .btn-primary").click();
  cy.get(":nth-child(2) > .control-label").click();
}

export const logIn = (usernameKey: string, passwordKey: string) => {
  cy.get("#user_email").clear();
  cy.get("#user_email").type(Cypress.env(usernameKey));
  cy.get(":nth-child(3) > .control-label").click();
  cy.get("#user_password").clear();
  cy.get("#user_password").type(Cypress.env(passwordKey));
  cy.get(".custom-control-label").click();
  cy.get("#user_persistent_session").check();
  cy.get("form > .btn-primary").click();
}