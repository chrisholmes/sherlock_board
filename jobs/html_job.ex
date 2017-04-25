defmodule SherlockBoard.HtmlJob do
  import SherlockBoard.Job

  def run do
    send_html("html","<p>Hello World</p>")
  end

  def period, do: 2
end
