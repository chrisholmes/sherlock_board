import SherlockBoard.Job
job "JobFixtures.B", 2 do
  send_event("event", %{value: "bar"})
end
