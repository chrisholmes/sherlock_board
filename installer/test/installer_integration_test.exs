defmodule SherlockBoard.Installer.IntegrationTest do
  Mix.shell(Mix.Shell.Process)
  use ExUnit.Case, async: true
  use SherlockBoard.Installer.IntegrationCase

  @app_name "my_test_board"

  setup do
    Application.ensure_all_started(:hound)
    cd = Temp.mkdir! "my-test-dir"
    prev_cd = File.cwd!
    File.cd!(cd)
    send self(), {:mix_shell_input, :yes?, "y"}
    Mix.Tasks.Sherlock.New.run([@app_name, "--dev"])
    assert_received {:mix_shell, :info, ["my_test_board has been created."]}
    port = Port.open({:spawn, "mix phoenix.server"}, [:binary, cd: @app_name])
    log_line = "[info] Running SherlockBoard.Endpoint with Cowboy using http://localhost:4000\n"
    assert_receive({^port, {:data, ^log_line}}, 60000)
    {:os_pid, process_id} = Port.info(port, :os_pid)
    {:ok }
    on_exit fn ->
      File.cd!(prev_cd)
      send port, {self(), :close}
      System.cmd("kill", ["-9", to_string(process_id)])
    end
  end

  @tag timeout: 120000
  test "it name is provided it will create a directory" do 
    navigate_to("http://localhost:4000/sample")
    wait_until fn ->
      assert visible_in_element?({:css, "div.box div.html-widget"}, ~r/Hello World/)
    end
  end
end
