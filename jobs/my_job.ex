defmodule SherlockBoard.MyJob do
  import SherlockBoard.Job

  def run do
    send_html("html","<p>Hello World</p>")
    send_event("event", %{value: "bar"})
  end

  def period, do: 2
end
