defmodule Integration.GasLawsTest do
  use Hound.Helpers
  use ExUnit.Case

  # Hit an ExUnit timeout without increasing this.
  @tag timeout: 180_000

  # @chromeArgs ["--headless", "--disable-gpu", "--allow-insecure-localhost"]
  @chromeArgs ["--allow-insecure-localhost"]

  hound_session(driver: %{chromeOptions: %{"args" => @chromeArgs}})

  test "Gas Laws content" do
    try do
      set_window_size(
        current_window_handle(),
        1000,
        800
      )

      reset_enter_lesson()

      # This button is custom & in an iframe.
      AdaptiveLessonPage.click_spr_button("start lessonz")

      page_1()
      page_2()
      page_3()
      page_4()
      page_5()

      # Pages 6 - just a single click, just doing it here to simplify
      AdaptiveLessonPage.click_next()

      # Page 7,8,9 - There's a standard multiple choice flow, so here's a helper.
      #    Unlike page 5, where we exercise both correct and incorrect values, we just
      #    get these correct on the first try to quickly get through them.
      AdaptiveLessonPage.complete_mc_page({:css, "[for=Cylinders-item-2]"})
      AdaptiveLessonPage.complete_mc_page({:css, "[for=PressureVolume-item-1]"})
      AdaptiveLessonPage.complete_mc_page({:css, "[for=Inverse-item-1]"})

      page_10()
      page_11()

      # 12
      AdaptiveLessonPage.click_next()

      page_13()

      # 14-16
      AdaptiveLessonPage.complete_mc_page({:css, "[for=ThreeTrialsTemp-item-2]"})
      AdaptiveLessonPage.complete_mc_page({:css, "[for=GraphRelationship-item-0]"})
      AdaptiveLessonPage.complete_mc_page({:css, "[for=Equation-item-2]"})

      page_17()

      # TODO - This is about half the lesson, but it demonstrates all the activity types, so we're calling it done for this demo.
    rescue
      error ->
        # TODO - this catch didn't work. not sure how to get screenshots of failing tests in CI.
        take_screenshot()
        raise error
    end

    # While actively working on tests, having a big long sleep at the end to see where it finishes was often helpful.
    # :timer.sleep(15000)
  end

  def page_1 do
    # TODO - would be better to search for a specific element with the text instead of any element, maybe add an ID?
    # Or even better, maybe add some aria-labels so we get better accessibility and testability at the same time.
    assert find_element(:xpath, "//*[contains(text(), 'Gases In Our World')]")
    AdaptiveLessonPage.click_next()
  end

  def page_2 do
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

  def page_3 do
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

  def page_4 do
    # TODO - better solution than sleep
    :timer.sleep(2000)

    AdaptiveLessonPage.scroll(2000)

    find_element(:css, "#BoylesExperiment > iframe")
    |> focus_frame()

    changed = find_element(:xpath, "(//*[contains(@class,'group-area ')])[2]")
    same = find_element(:xpath, "(//*[contains(@class,'group-area ')])[3]")

    find_element(:xpath, "//*[@class='item-text'][text()='Pressure']")
    |> AdaptiveLessonPage.drag(changed)

    # ui-sortable need a brief wait between drags to register them correctly
    :timer.sleep(1000)

    find_element(:xpath, "//*[@class='item-text'][text()='Container volume']")
    |> AdaptiveLessonPage.drag(changed)

    :timer.sleep(1000)

    find_element(:xpath, "//*[@class='item-text'][text()='Temperature']")
    |> AdaptiveLessonPage.drag(same)

    :timer.sleep(1000)

    find_element(:xpath, "//*[@class='item-text'][text()='Number of gas molecules']")
    |> AdaptiveLessonPage.drag(same)

    :timer.sleep(1000)

    focus_parent_frame()

    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_correct_feedback()
  end

  def page_5() do
    # Need this wait so the page fully renders, or the scroll doesn't get us far enough.
    :timer.sleep(1000)

    AdaptiveLessonPage.scroll(2000)

    click(
      {:xpath,
       "//label[div/p/span[text()='Decreasing the volume decreases the pressure in the cylinder.']]"}
    )

    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_wrong_feedback()

    click(
      {:xpath,
       "//label[div/p/span[text()='Decreasing the volume increases the pressure in the cylinder.']]"}
    )

    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_correct_feedback()
  end

  def page_10() do
    fill_field({:id, "NewVolume-number-input"}, "5")
    AdaptiveLessonPage.click_next()

    AdaptiveLessonPage.close_wrong_feedback()
    element = find_element(:id, "NewVolume-number-input")
    clear_field(element)
    fill_field(element, "6")

    # For some reason, on this page, if you don't wait a bit between filling in thas answer and checking the feedback,
    # you'll sometimes get an incorrect result with the correct answer.
    :timer.sleep(2000)
    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_correct_feedback()
  end

  def page_11() do
    :timer.sleep(1000)
    AdaptiveLessonPage.scroll(500)

    find_element(:css, "#Boyle > iframe")
    |> focus_frame()

    click({:id, "drop-1-button"})
    click({:xpath, "//li[contains(@class,'ui-menu-item')][text()='temperature']"})

    click({:id, "drop-2-button"})

    # This is annoying, all the dropdowns are on the screen, but only some visible, so to get an item from the
    # second dropdown by text like this, we have to index into it because the previous dropdown also had a "volume" option
    click({:xpath, "(//li[contains(@class,'ui-menu-item')][text()='volume'])[2]"})

    click({:id, "drop-3-button"})
    click({:xpath, "(//li[contains(@class,'ui-menu-item')][text()='decrease'])[3]"})

    click({:id, "drop-4-button"})
    click({:xpath, "(//li[contains(@class,'ui-menu-item')][text()='inverse'])[4]"})

    focus_parent_frame()

    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_correct_feedback()
  end

  def page_13 do
    # TODO - better solution than sleep
    :timer.sleep(2000)

    AdaptiveLessonPage.scroll(2000)

    find_element(:css, "#ThreeTrialsSame > iframe")
    |> focus_frame()

    changed = find_element(:xpath, "(//*[contains(@class,'group-area ')])[2]")
    same = find_element(:xpath, "(//*[contains(@class,'group-area ')])[3]")

    find_element(:xpath, "//*[@class='item-text'][text()='Pressure']")
    |> AdaptiveLessonPage.drag(changed)

    # ui-sortable need a brief wait between drags to register them correctly
    :timer.sleep(1000)

    find_element(:xpath, "//*[@class='item-text'][text()='The volume of the container']")
    |> AdaptiveLessonPage.drag(same)

    :timer.sleep(1000)

    find_element(:xpath, "//*[@class='item-text'][text()='Temperature']")
    |> AdaptiveLessonPage.drag(changed)

    :timer.sleep(1000)

    find_element(:xpath, "//*[@class='item-text'][text()='The number of gas molecules']")
    |> AdaptiveLessonPage.drag(same)

    :timer.sleep(1000)

    focus_parent_frame()

    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_correct_feedback()
  end

  def page_17() do
    fill_field({:id, "NewPressure-number-input"}, "5")
    AdaptiveLessonPage.click_next()

    AdaptiveLessonPage.close_wrong_feedback()
    element = find_element(:id, "NewPressure-number-input")
    clear_field(element)
    fill_field(element, "3.8775")

    # For some reason, on this page, if you don't wait a bit between filling in thas answer and checking the feedback,
    # you'll sometimes get an incorrect result with the correct answer.
    :timer.sleep(1000)
    AdaptiveLessonPage.click_next()
    AdaptiveLessonPage.close_correct_feedback()
  end

  def reset_enter_lesson do
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
