describe("My First Test", () => {
  it("Does not do much!", () => {
    expect(true).to.equal(true);

    //"https://torus.qa.argos.education/authoring/project/sample_project_udw5v"
    cy.visit("https://torus.qa.argos.education/authoring/session/new");
    cy.wait(500);
    cy.get("h5").contains("We use cookies").should("be.visible");

    cy.get("button").contains("Accept").click();

    // e2e-student@argos.education
    cy.get("#user_email").type("e2e-author@argos.education", { force: true });
    cy.get("#user_password").type(
      "6162e6953c1f23e681a89b7e1357f30c770266864ac5ffff13c1bd8d59910e72",
      { force: true }
    );

    cy.get("button").contains("Sign In").click();

    /* ==== Generated with Cypress Studio ==== */
    cy.get("#\\31 943 > :nth-child(1) > a").click();
    cy.get("#project_title").clear();
    cy.get("#project_title").type("Sample Project Edited Name");
    cy.get("#project_description").click();
    cy.get(".float-right").click();
    cy.get(".sidebar-item.my-1 > img").click();
    cy.get("#\\31 943 > :nth-child(1) > a").should(
      "have.text",
      "Sample Project Edited Name"
    );

    cy.visit(
      "https://torus.qa.argos.education/authoring/project/sample_project_fuyn4/objectives"
    );
    cy.get(".form-inline > #form-create-objective").clear();
    cy.get(".form-inline > #form-create-objective").type(
      "Here is my objective."
    );
    cy.get(".form-inline > .btn").click();
    /* ==== End Cypress Studio ==== */
  });
});
