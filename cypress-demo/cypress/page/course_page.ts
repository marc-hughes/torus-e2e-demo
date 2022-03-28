export const clickCourse = (courseName: string) => {
    cy.get(".card-title").contains(courseName).click();
}


