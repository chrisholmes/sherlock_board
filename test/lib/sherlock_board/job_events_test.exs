defmodule SherlockBoard.JobEventsTest do
  use ExUnit.Case, async: true
  alias SherlockBoard.JobEvents

  describe "broadcast\1" do
    test "it broadbcasts messages to consumers" do
      {:ok, pid} = JobEvents.start_link_unnamed
      JobEvents.broadcast({"foo", {"baz"}}, pid)
      message = GenStage.stream([pid]) |> Enum.find(fn(message) -> 
        message == {"foo", {"baz"}}
      end)
      assert message == {"foo", {"baz"}}
    end
  end

  describe "stream\1" do
    test "it broadbcasts messages to consumers" do
      {:ok, pid} = JobEvents.start_link_unnamed
      JobEvents.broadcast({"foo", {"baz"}}, pid)
      message = JobEvents.stream(pid) |> Enum.find(fn(message) -> 
        message == {"foo", {"baz"}}
      end)
      assert message == {"foo", {"baz"}}
    end
  end
end
