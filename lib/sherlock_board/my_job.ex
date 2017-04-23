defmodule SherlockBoard.MyJob do
  import SherlockBoard.Job

  def run do
    send_event("my_job", %{"content" => "Hello World"})
  end

  def period, do: 2
end
