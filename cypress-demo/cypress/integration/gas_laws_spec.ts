import * as LoginPage from "../page/login_page";
import * as CoursesPage from "../page/course_page"
import * as AdaptiveLesson from "../page/adaptive_lesson_page";

describe("Gas Laws", () => {

  it("Test the GasLaws content", () => {

    enterLesson();
    AdaptiveLesson.restartLesson();

    AdaptiveLesson.clickSprButton("start lesson")

    page1();
    page2();
    page3();
    page4();
    page5();

    //Page 6 is just a single click
    AdaptiveLesson.clickNext();

    // Page 7,8,9 - There's a standard multiple choice flow, so here's a helper.
    //    Unlike page 5, where we exercise both correct and incorrect values, we just
    //    get these correct on the first try to quickly get through them.
    AdaptiveLesson.completeMCPage("[for=Cylinders-item-2]")
    AdaptiveLesson.completeMCPage("[for=PressureVolume-item-1]")
    AdaptiveLesson.completeMCPage("[for=Inverse-item-1]")

    page10();
    page11();

    AdaptiveLesson.clickNext() // Page 12

    page13();

    //cy.pause() // <-- Example of starting the interactive debugger

    // 14 - 16
    AdaptiveLesson.completeMCPage("[for=ThreeTrialsTemp-item-2]")
    AdaptiveLesson.completeMCPage("[for=GraphRelationship-item-0]")
    AdaptiveLesson.completeMCPage("[for=Equation-item-2]")

    page17();

    cy.log("Stopping after page 17 for this demo")

  });

  const enterLesson = () => {
    const host = Cypress.env("host");
    cy.visit(host + "/");

    LoginPage.closeCookieDialog();
    LoginPage.goToEducatorLogin();
    LoginPage.logIn(
      "gas_student_username",
      "gas_student_password"
    );

    CoursesPage.clickCourse("Critical Chem: The Science of Saving Lives")

    cy.get(".page-title").contains("Gas Laws").click();
  }






  const page1 = () => {
    cy.log("# Page 2")
    cy.get("div").contains("Gases In Our World").should("be.visible")
    AdaptiveLesson.clickNext()
  }

  const page2 = () => {
    cy.log("# Page 3")
    cy.get("div").contains("Ready, Set, Go!").should("be.visible")

    AdaptiveLesson.clickNext()
    AdaptiveLesson.checkFeedback("Please make a selection before moving on.")
    AdaptiveLesson.closeWrongFeedback()


    cy.get("label").contains("Yes.").click();
    AdaptiveLesson.clickNext()
    AdaptiveLesson.clickNext() // This one was weird, double next button instead of next then correct feedback button. Bug?
  }



  const page3 = () => {
    cy.log("# Page 4")
    cy.get("div").contains("Assumptions about Gases").should("be.visible")
    AdaptiveLesson.clickNext();
    AdaptiveLesson.closeWrongFeedback();

    cy.get('label[for="GasAssumptions-item-0"]').click();
    AdaptiveLesson.clickNext();
    AdaptiveLesson.checkFeedback("chosen the image that doesn’t violate any of the assumptions. Let’s jump into making some observations of an experiment on gases.")
    AdaptiveLesson.closeCorrectFeedback();
  }

  const page4 = () => {
    cy.log("# Page 5")
    cy.get("div").contains("Make Some Observations").should("be.visible")

    cy.enter("#BoylesExperiment iframe").then(getIframe => {
      // This tool lives inside an iframe, so only try to interact with it inside blocks like these

      // First, let's check that a couple items exist & are visible since the iframe could load far slower than the
      // page it's hosted on and we don't want to start dragging too early.
      getIframe().find(".item .item-text").eq(1).should("be.visible");
      getIframe().find(".group-area-wrapper").eq(2).should("be.visible");

      // TODO: Using a constant drag distance right now, but we should query location of each drop spot
      // and caluclate that to support the design changing without having to update the test.
      AdaptiveLesson.dragGroupingToolRight(getIframe(), "Pressure", 250);
      AdaptiveLesson.dragGroupingToolRight(getIframe(), "Number of gas molecules", 500);
      AdaptiveLesson.dragGroupingToolRight(getIframe(), "Temperature", 500);
      AdaptiveLesson.dragGroupingToolRight(getIframe(), "Container volume", 250);
    });

    // Now that we've dragged our boxes into the right spots, lets check it.
    AdaptiveLesson.clickNext();
    AdaptiveLesson.checkFeedback("That’s correct! The pressure and volume of the container changed during the experiment but the temperature and number of particles haven’t changed. Let’s see if we can extract a general principle from this.")
    AdaptiveLesson.closeCorrectFeedback();
  }

  const page5 = () => {
    cy.log("Page 5")
    cy.get("label").contains('Decreasing the volume decreases the pressure in the cylinder.').click()
    AdaptiveLesson.clickNext()
    AdaptiveLesson.closeWrongFeedback();

    cy.get("label").contains('Decreasing the volume increases the pressure in the cylinder.').click()
    AdaptiveLesson.clickNext()
    AdaptiveLesson.closeCorrectFeedback()
  }

  const page10 = () => {
    cy.log("Page 10")
    cy.get("#NewVolume-number-input").type("5")
    AdaptiveLesson.clickNext()
    AdaptiveLesson.closeWrongFeedback();

    cy.get("#NewVolume-number-input").type("{backspace}6")

    AdaptiveLesson.clickNext();
    AdaptiveLesson.closeCorrectFeedback();
  }

  const page11 = () => {
    cy.log("Page 11")

    cy.enter("#Boyle > iframe").then(getBody => {
      getBody().find("#drop-1-button").click();
      getBody().find("#drop-1-menu .ui-menu-item").contains("temperature").click();

      getBody().find("#drop-2-button").click();
      getBody().find("#drop-2-menu .ui-menu-item").contains('volume').click();

      getBody().find("#drop-3-button").click();
      getBody().find("#drop-3-menu .ui-menu-item").contains("decrease").click()

      getBody().find("#drop-4-button").click();
      getBody().find("#drop-4-menu .ui-menu-item").contains("inverse").click();

    })

    AdaptiveLesson.clickNext();
    AdaptiveLesson.closeCorrectFeedback();
  }


  const page13 = () => {
    cy.log("Page 13")

    cy.enter("#ThreeTrialsSame iframe").then(getBody => {
      // This tool lives inside an iframe, so only try to interact with it inside blocks like these

      // First, let's check that a couple items exist & are visible since the iframe could load far slower than the
      // page it's hosted on and we don't want to start dragging to early.
      getBody().find(".item .item-text").eq(1).should("be.visible");
      getBody().find(".group-area-wrapper").eq(2).should("be.visible");

      // TODO: Using a constant drag distance right now, but we should query location of each drop spot
      // and caluclate that to support the design changing without having to update the test.
      AdaptiveLesson.dragGroupingToolRight(getBody(), "Pressure", 250);
      AdaptiveLesson.dragGroupingToolRight(getBody(), "The volume of the container", 500);
      AdaptiveLesson.dragGroupingToolRight(getBody(), "Temperature", 250);
      AdaptiveLesson.dragGroupingToolRight(getBody(), "The number of gas molecules", 500);
    });

    AdaptiveLesson.clickNext()
    AdaptiveLesson.closeCorrectFeedback();
  }

  const page17 = () => {
    cy.log("Page 17")
    cy.get("#NewPressure-number-input").type("5")
    AdaptiveLesson.clickNext()
    AdaptiveLesson.closeWrongFeedback();

    cy.get("#NewPressure-number-input").type("{backspace}3.8775")

    AdaptiveLesson.clickNext()
    AdaptiveLesson.closeCorrectFeedback()

  }

});
