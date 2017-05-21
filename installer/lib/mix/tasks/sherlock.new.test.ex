defmodule Mix.Tasks.Sherlock.New.Test do
  @app_name "my_test_board"
  def run([]) do
    Mix.shell(Mix.Shell.Process)
    Temp.track!
    cd = Temp.mkdir! "my-dir"
    prev_cd = File.cwd!
    send self(), {:mix_shell_input, :yes?, true}
    File.cd!(cd, fn -> run_test end)
  end

  def run_test do
    Mix.Tasks.Sherlock.New.run([@app_name, "--dev"])
    File.cd!(@app_name, fn -> 
     {stdout, status} = System.cmd("mix", ["test"])
     IO.puts stdout
     if status != 0, do: exit status
    end)
  end
end
