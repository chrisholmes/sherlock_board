import SherlockBoard.Job

job :chart_job, 2 do
  now = DateTime.utc_now
  chart_data = Enum.into(10..0, []) 
                |> Stream.map(fn(n) -> now.second - (n*2) end)
                |> Enum.map(fn(n) ->
  if n < 0 do
    n + 60
  else
    n
  end
                end)
  send_event("now", %{value: now.second})
  send_event("chart", %{
      labels: Enum.into(-10..0, []) |> Enum.map(fn(n) -> n * 2 end),
      datasets: [
        %{ data: chart_data }
      ]
    })
end
