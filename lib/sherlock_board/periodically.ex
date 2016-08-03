defmodule SherlockBoard.Periodically do
  use GenServer

  def start_link(job) do
    GenServer.start_link(__MODULE__, job)
  end

  def init(job) do
    schedule_work(job) # Schedule work to be performed at some point
    {:ok, job}
  end

  def handle_info(:work, job) do
    job.run()
    schedule_work(job) # Reschedule once more
    {:noreply, job}
  end

  defp schedule_work(job) do
    Process.send_after(self(), :work, job.period ) # In 2 hours
  end
end
