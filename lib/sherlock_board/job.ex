defmodule SherlockBoard.Job do
  alias SherlockBoard.Endpoint
  def send_event(name, data) do
    Endpoint.broadcast("jobs", name, data)
  end

  def send_html(name, html) do
    Endpoint.broadcast("jobs", name, %{html: html})
  end
end
