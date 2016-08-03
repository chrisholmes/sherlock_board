defmodule SherlockBoard.JobOutputTest do
  use SherlockBoard.ChannelCase

  alias SherlockBoard.JobChannel

  defmodule TestJob do
    import SherlockBoard.Job

    def run do
      send_event("test_job", %{"foo" => "bar"} )
    end
  end

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(JobChannel, "jobs:test_job")

    {:ok, socket: socket}
  end

  test "when a job sends an event it is broadcast to a channel" do
    TestJob.run
    assert_push "event", %{"foo" => "bar"}
  end
end

