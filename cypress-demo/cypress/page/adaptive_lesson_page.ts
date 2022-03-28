export const restartLesson = () => {
  // TODO - it would be far better to call a server side API to do this & properly set up the test instead every test run.
  cy.get('button[aria-label="Show lesson history"]').click();
  cy.get("button").contains("Restart Lesson").click();
  cy.get("button").contains("OK").click();
};



const sprButton = () => cy.iframe(
  '[src="https://reflector.argos.education/reflector/sim/spr-widget-buttonwidget/prod/2.0.*"]'
  // TODO - having some identifiers to find these would be swell instead of by src location since this is going
  //        to fail on the first page with multiple buttons on it.
)

export const sprGroupingTool = () => cy.enter('[src="https://reflector.argos.education/reflector/sim/spr-widget-grouping/prod/1.*"]')


export const clickSprButton = (label) => sprButton().find(".button")
  .contains(label)
  .should("be.visible")
  .click({ force: true });

export const clickNext = (nextLabel = "Next") => cy.get("button.checkBtn").contains(nextLabel).click();

export const closeWrongFeedback = () => cy.get(".closeFeedbackBtn.wrongFeedback").click();

export const closeCorrectFeedback = () => cy.get(".closeFeedbackBtn.correctFeedback").click();

export const checkFeedback = (expectedFeedbackSubstr) => cy.contains(expectedFeedbackSubstr).should("be.visible");

export const dragGroupingToolRight = (iframe, label, amount) => {

  iframe
    .wait(500)  // UI-Dragable doesn't like quick no-wait drags and doesn't register them if you don't have a short wait.
    .find(".item")
    .contains(label)
    // The coordinates don't really matter, but the relative distance between the mouse-down and the mouse-move do.
    // For *reasons*, ui-sortable needs pageX/pageY and not clientX/clientY
    .trigger('mousedown', { which: 1, pageX: 100, pageY: 100 })
    .trigger('mousemove', { which: 1, pageX: 100 + amount, pageY: 100 })
    .trigger('mouseup');

}
