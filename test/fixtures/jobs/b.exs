defmodule JobFixtures.B do
  import SherlockBoard.Job

  def run do
    send_event("event", %{value: "bar"})
  end

  def period, do: 2
end
