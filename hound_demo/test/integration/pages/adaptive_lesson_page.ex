defmodule AdaptiveLessonPage do
  use Hound.Helpers

  import PageHelper

  def reset_lesson do
    # TODO - it would be far better to call a server side API to do this & properly set up the test instead every test run.

    # These clicks were really flakey and failing sometimes, wrote up this new wait_click function to help solve that, see PageHelper
    wait_click(:css, "[aria-label='Show lesson history']")
    wait_click(:xpath, "//span[text() = 'Restart Lesson']")
    wait_click(:xpath, "//*[contains(@class, 'RestartLessonDialog')]//button[text()='OK']")
  end

  def click_spr_button(label) do
    # TODO - having some identifiers to find these would be swell instead of by src location since this is going
    #        to fail on the first page with multiple buttons on it.
    #        Since the buttons are in separate document contexts, you can't do something like //iframe/button[@text='blah] to
    #        search them all.

    iframe =
      find_element(
        :css,
        "[src='https://reflector.argos.education/reflector/sim/spr-widget-buttonwidget/prod/2.0.*']"
      )

    focus_frame(iframe)
    click({:xpath, "//*[contains(text(),'#{label}')]"})
    focus_parent_frame()
  end

  def click_next(label \\ "Next") do
    wait_click(:xpath, "//button[@class='checkBtn'][div[text()='#{label}']]")
  end

  def get_feedback() do
    {:ok, _} = wait_for_visible(:css, ".feedbackContainer")
    feedback = find_element(:xpath, "//*[@class='feedback-item']//span")
    inner_text(feedback)
  end

  def close_correct_feedback() do
    # Without this wait, we sometimes get it while animating and don't progress correctly
    :timer.sleep(500)
    wait_click(:css, ".closeFeedbackBtn.correctFeedback")
  end

  def close_wrong_feedback() do
    # Without this wait, we sometimes get it while animating and don't progress correctly
    :timer.sleep(500)
    PageHelper.wait_for_visible(:css, ".closeFeedbackBtn.wrongFeedback")
    wait_click(:css, ".closeFeedbackBtn.wrongFeedback")
  end

  def scroll(y_position) do
    execute_script("document.querySelector('.mainView').scrollTop = #{y_position};")
  end

  def completeMCQPage(correctAnswer) do
    # Need to wait for the page to fully render so we can scroll far enough
    :timer.sleep(1000)
    scroll(2000)
    click(correctAnswer)
    click_next()
    close_correct_feedback()
  end

  def drag(item, destination) do
    # May need to get smarter about these coordinates some day, but just picking a spot 5px,5px inside the elements works for this
    move_to(item, 5, 5)
    mouse_down()
    move_to(destination, 5, 5)
    mouse_up()
  end
end
