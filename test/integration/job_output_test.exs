defmodule SherlockBoard.JobOutputTest do
  use ExUnit.Case, async: true

  test "when a job sends an event it is broadcast to a channel with its period" do
    require SherlockBoard.Job
    period = 2
    SherlockBoard.Job.job :TestJob, 2 do
      send_event("test_job", %{"foo" => "bar"} )
    end
    SherlockBoard.Job.TestJob.run

    # Would like to use a conn here, but the test conn blocks and never returns
    # when trying to access server sent events
    event = SherlockBoard.JobEvents.stream
            |> Enum.find(fn(x) -> {"test_job", %{:period => 2, "foo" => "bar"}} end)
    assert event == {"test_job", %{:period => 2, "foo" => "bar"}}
  end
end

