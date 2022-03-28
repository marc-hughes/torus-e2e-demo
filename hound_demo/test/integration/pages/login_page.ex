defmodule LoginPage do
  use Hound.Helpers

  def open do
    navigate_to("#{Application.get_env(:hound_demo, :host)}/")
  end

  def close_cookie_prompt do
    # Make sure the dialog & button are there
    # Then click the accept button
    with {:ok, _} <- search_element(:xpath, "//*[text() = 'We use cookies']"),
         {:ok, button} <- search_element(:xpath, "//*[text() = 'Accept']") do
      click(button)
    else
      # No big deal TODO: is there better logging methods?
      {:error, _} -> IO.puts("Warning: No cookie dialog")
    end
  end

  def go_to_educator_login do
    # TODO - It would be better for these to have explicit id or aria-label attributes instead of relying on the implemention-detail of the url they go to
    click({:xpath, "//*[@href='/session/new']"})
  end

  def login("", _), do: IO.puts("Username / Password not specified")
  def login(_, ""), do: IO.puts("Username / Password not specified")

  def login(username, password) do
    element = find_element(:id, "user_email")
    fill_field(element, username)
    element = find_element(:id, "user_password")
    fill_field(element, password)
    submit_element(element)
  end
end
