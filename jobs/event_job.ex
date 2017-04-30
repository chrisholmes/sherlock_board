import SherlockBoard.Job

job :event_job, 2 do
  send_event("event", %{value: "bar"})
end
