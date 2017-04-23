defmodule SherlockBoard.MyJob do
  import SherlockBoard.Job

  def run do
    send_html("my_job", "<p>Hello World</p>")
  end

  def period, do: 2
end
