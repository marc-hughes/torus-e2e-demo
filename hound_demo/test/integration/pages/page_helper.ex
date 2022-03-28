defmodule PageHelper do
  use Hound.Helpers

  @max_wait 5000

  def wait_click(strategy, selector) do
    {:ok, element} = wait_for_interactable(strategy, selector)
    click(element)
  end

  def wait_for_visible(strategy, selector) do
    wait_for_visible(strategy, selector, 10)
  end

  defp wait_for_visible(_, _, last_wait) when last_wait > @max_wait do
    {:error, "Element not visible"}
  end

  defp wait_for_visible(strategy, selector, last_wait) do
    element = find_element(strategy, selector)

    if element_displayed?(element) do
      {:ok, element}
    else
      # The element wasn't ready yet, lets wait a bit and try again.
      # Start with a short wait, and progressively use a longer wait to back off gracefully.
      :timer.sleep(last_wait * 2)
      wait_for_visible(strategy, selector, last_wait * 2)
    end
  end

  # some helper-functions to use in our page objects
  def wait_for_interactable(strategy, selector) do
    wait_for_interactable(strategy, selector, 10)
  end

  defp wait_for_interactable(_, _, last_wait) when last_wait > @max_wait do
    {:error, "Element not interactable"}
  end

  defp wait_for_interactable(strategy, selector, last_wait) do
    element = find_element(strategy, selector)

    if element_displayed?(element) and element_enabled?(element) do
      {:ok, element}
    else
      # The element wasn't ready yet, lets wait a bit and try again.
      # Start with a short wait, and progressively use a longer wait to back off gracefully.
      :timer.sleep(last_wait * 2)
      wait_for_interactable(strategy, selector, last_wait * 2)
    end
  end
end
