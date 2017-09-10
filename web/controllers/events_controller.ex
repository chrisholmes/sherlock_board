defmodule SherlockBoard.EventsController do
  use SherlockBoard.Web, :controller
  require Logger
  alias SherlockBoard.JobEvents

  def events(conn, _params) do
    conn = conn
    |> put_resp_header("content-type", "text/event-stream")
    |> send_chunked(200)

    JobEvents.stream |> Enum.reduce_while(conn, &send_event_reducer/2)
  end

  defp send_event_reducer({:error, _reason}, conn) do
    conn
  end

  defp send_event_reducer(event, conn) do
    case send_event(conn, event) do
      {:ok, new_conn} -> {:cont, new_conn}
      {:error, _reason} -> {:halt, conn}
    end
  end

  defp send_event(conn, {name, data}) do
    message = "event: " <> name <> "\n" <>
      "data: " <> Poison.encode!(data) <> "\n\n"
    chunk(conn, message) 
  end
end
