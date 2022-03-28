defmodule Integration.GasLawsTest do
  use Hound.Helpers
  use ExUnit.Case

  # import PageHelper

  hound_session()

  test "Gas Laws content" do
    reset_enter_lesson()

    AdaptiveLessonPage.click_spr_button("start lesson")

    first_page()
    second_page()
    third_page()
    fourth_page()

    :timer.sleep(15000)
  end

  def first_page do
    # TODO - would be better to search for a specific element with the text instead of any element, maybe add an ID?
    assert find_element(:xpath, "//*[contains(text(), 'Gases In Our World')]")
    AdaptiveLessonPage.click_next()
  end

  def second_page do
    assert find_element(:xpath, "//*[contains(text(), 'Ready, Set, Go!')]")

    # Ran into an issue here where clicking the options failed because they were behind the bottom footer bar
    # Running some JS on the client was the only way I could see to get around that and requires some knowledge
    # of what should be scrolled.
    AdaptiveLessonPage.scroll(1000)

    # Pick the "No" option - I'd much prefer to search for "No" instead of relying on it being the
    # second option, but the xpath queries don't seem to entirely work across WebComponent boundaries
    # There might be a more elegant solution than this stil, added some notes related to this
    # in hound_demo/Readme.md about selectors.
    # No.
    click({:xpath, "//label[@for='Begin-item-1']"})
    AdaptiveLessonPage.click_next()

    assert AdaptiveLessonPage.get_feedback() =~
             "take a moment to get ready. Maybe you’d like to grab a snack and a drink or take a quick walk before returning here to jump in."

    AdaptiveLessonPage.close_correct_feedback()
  end

  def third_page do
    # This page is a little annoying, we have to wait for the images to load before we scroll, or we can't scroll far enough.
    # TODO: We can do better than a sleep
    :timer.sleep(2000)

    AdaptiveLessonPage.scroll(2000)
    incorrect_option = find_element(:css, "label[for='GasAssumptions-item-1']")
    click(incorrect_option)
    AdaptiveLessonPage.click_next()

    # If you don't wait, you get the old feedback, probably a race condition between the test & the app
    # TODO: Can we write a "wait for the text to equal X" type function
    :timer.sleep(2000)

    assert AdaptiveLessonPage.get_feedback() =~
             "The image you chose of the particles all on the bottom of the container is incorrect because it violates the first assumption, “Gases have no definite shape or volume.They expand spontaneously to fill their containers”.Take another look at the images and the assumptions, then try again."

    AdaptiveLessonPage.close_wrong_feedback()

    correct_option = find_element(:css, "label[for='GasAssumptions-item-0']")
    click(correct_option)

    AdaptiveLessonPage.click_next()

    :timer.sleep(2000)

    assert AdaptiveLessonPage.get_feedback() =~
             "That’s right. You’ve chosen the image that doesn’t violate any of the assumptions. Let’s jump into making some observations of an experiment on gases."

    AdaptiveLessonPage.close_correct_feedback()
  end

  def fourth_page do
    # TODO - better solution than sleep
    :timer.sleep(2000)

    AdaptiveLessonPage.scroll(2000)

    iframe = find_element(:css, "#BoylesExperiment > iframe")
    focus_frame(iframe)

    changed = find_element(:xpath, "(//*[contains(@class,'group-area ')])[2]")
    same = find_element(:xpath, "(//*[contains(@class,'group-area ')])[3]")

    pressure = find_element(:xpath, "//*[@class='item-text'][text()='Pressure']")
    pressure = find_element(:xpath, "//*[@class='item-text'][text()='']")
    pressure = find_element(:xpath, "//*[@class='item-text'][text()='Pressure']")
    pressure = find_element(:xpath, "//*[@class='item-text'][text()='Pressure']")

    drag(pressure, changed)

    focus_parent_frame()
  end

  def drag(item, destination) do
    move_to(item, 5, 5)
    mouse_down()
    move_to(destination, 5, 5)
    mouse_up()
  end

  def reset_enter_lesson do
    set_window_size(
      current_window_handle(),
      1000,
      800
    )

    LoginPage.open()
    LoginPage.close_cookie_prompt()
    LoginPage.go_to_educator_login()

    LoginPage.login(
      Application.get_env(:hound_demo, :gas_student_username),
      Application.get_env(:hound_demo, :gas_student_password)
    )

    CoursesPage.click_course("Critical Chem: The Science of Saving Lives")
    CoursesPage.click_lesson("Gas Laws")

    AdaptiveLessonPage.reset_lesson()
  end
end
