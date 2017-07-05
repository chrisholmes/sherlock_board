defmodule SherlockBoard.JobSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    supervise(job_workers!, strategy: :one_for_one)
  end

  defp directory do
    sherlock_directory = Application.get_env(:sherlock_board, :directory)
    Path.join(sherlock_directory, "jobs")
  end

  defp create_worker(job) do
    worker(SherlockBoard.Periodically, [job], [id: make_ref]) 
  end

  defp load!(directory) do
    SherlockBoard.JobLoader.load(directory)
  end

  defp job_workers! do
    directory |> load! |> Enum.map(&create_worker/1)
  end
end
