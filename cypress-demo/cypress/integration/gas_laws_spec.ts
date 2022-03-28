import * as LoginPage from "../page/login_page";
import * as CoursesPage from "../page/course_page"
import * as AdaptiveLesson from "../page/adaptive_lesson_page";

describe("Gas Laws", () => {

  it("Test the GasLaws content", () => {
    resetEnterLesson();
    firstPage();
    secondPage();
    thirdPage();
    fourthPage();
    fifthPage();
  });

  const resetEnterLesson = () => {
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

    AdaptiveLesson.restartLesson();
  }

  const firstPage = () => {
    cy.log("# Page 1")
    // Now we can go hit that iframed start lesson button
    AdaptiveLesson.clickSprButton("start lesson")
  }

  const secondPage = () => {
    cy.log("# Page 2")
    cy.get("div").contains("Gases In Our World").should("be.visible")
    AdaptiveLesson.clickNext()
  }

  const thirdPage = () => {
    cy.log("# Page 3")
    cy.get("div").contains("Ready, Set, Go!").should("be.visible")

    AdaptiveLesson.clickNext()
    AdaptiveLesson.checkFeedback("Please make a selection before moving on.")
    AdaptiveLesson.closeWrongFeedback()


    cy.get("label").contains("Yes.").click();
    AdaptiveLesson.clickNext()
    AdaptiveLesson.clickNext()
  }



  const fourthPage = () => {
    cy.log("# Page 4")
    cy.get("div").contains("Assumptions about Gases").should("be.visible")
    AdaptiveLesson.clickNext();
    AdaptiveLesson.closeWrongFeedback();

    cy.get('label[for="GasAssumptions-item-0"]').click();
    AdaptiveLesson.clickNext();
    AdaptiveLesson.checkFeedback("chosen the image that doesn’t violate any of the assumptions. Let’s jump into making some observations of an experiment on gases.")
    AdaptiveLesson.closeCorrectFeedback();
  }

  const fifthPage = () => {
    cy.log("# Page 5")
    cy.get("div").contains("Make Some Observations").should("be.visible")

    cy.get("#BoylesExperiment").scrollIntoView();

    AdaptiveLesson.sprGroupingTool().then(getBody => {
      // This tool lives inside an iframe, so only try to interact with it inside blocks like these

      // First, let's check that a couple items exist & are visible since the iframe could load far slower than the
      // page it's hosted on and we don't want to start dragging to early.
      getBody().find(".item .item-text").eq(1).should("be.visible");
      getBody().find(".group-area-wrapper").eq(2).should("be.visible");

      // TODO: Using a constant drag distance right now, but we should query location of each drop spot
      // and caluclate that to support the design changing without having to update the test.
      AdaptiveLesson.dragGroupingToolRight(getBody(), "Pressure", 250);
      AdaptiveLesson.dragGroupingToolRight(getBody(), "Number of gas molecules", 500);
      AdaptiveLesson.dragGroupingToolRight(getBody(), "Temperature", 500);
      AdaptiveLesson.dragGroupingToolRight(getBody(), "Container volume", 250);
    });

    // Now that we've dragged our boxes into the right spots, lets check it.
    AdaptiveLesson.clickNext();
    AdaptiveLesson.checkFeedback("That’s correct! The pressure and volume of the container changed during the experiment but the temperature and number of particles haven’t changed. Let’s see if we can extract a general principle from this.")
    AdaptiveLesson.closeCorrectFeedback();
  }



});
