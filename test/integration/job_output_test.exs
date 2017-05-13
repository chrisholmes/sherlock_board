defmodule SherlockBoard.JobOutputTest do
  use SherlockBoard.ChannelCase

  alias SherlockBoard.JobChannel


  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(JobChannel, "jobs")

    {:ok, socket: socket}
  end

  test "when a job sends an event it is broadcast to a channel with its period" do
    require SherlockBoard.Job
    SherlockBoard.Job.job :TestJob, 2 do
      send_event("test_job", %{"foo" => "bar"} )
    end
    SherlockBoard.Job.TestJob.run
    assert_push "test_job", %{"foo" => "bar", period: 2}
  end
end

