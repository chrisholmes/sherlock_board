defmodule SherlockBoard.MyJob do
  import SherlockBoard.Job

  def run do
    send_html("my_job","<p>Hello World</p>")
    send_event("my_job", %{value: "bar"})
  end

  def period, do: 2
end
