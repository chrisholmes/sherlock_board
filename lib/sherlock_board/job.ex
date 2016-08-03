defmodule SherlockBoard.Job do
  alias SherlockBoard.Endpoint
  def send_event(name, data) do
    Endpoint.broadcast("jobs:#{name}", "event", data)
  end

  def period do
    2
  end
end
