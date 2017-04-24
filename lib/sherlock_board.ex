defmodule SherlockBoard do
  use Application
  require Logger


  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    jobs_directory = Application.get_env(:jobs, :directory)
    jobs = SherlockBoard.JobLoader.load(jobs_directory)
    job_workers = Enum.map(jobs, fn(job) ->
      worker(SherlockBoard.Periodically, [job], [id: make_ref]) 
    end)
  
    # Start the endpoint when the application starts
    endpoint_supervisor = supervisor(SherlockBoard.Endpoint, [])
   
    children = [endpoint_supervisor|job_workers]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SherlockBoard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SherlockBoard.Endpoint.config_change(changed, removed)
    :ok
  end
end
