# Get Mix output sent to the current
# # process to avoid polluting tests.
Mix.shell(Mix.Shell.Process)

defmodule Mix.Tasks.Sherlock.NewTest do
  use ExUnit.Case, async: true

  @app_name "my_board"

  setup _context do
    cd = Temp.mkdir! "my-dir"
    prev_cd = File.cwd!
    File.cd!(cd)
    send self(), {:mix_shell_input, :yes?, false}
    on_exit fn ->
      File.cd!(prev_cd)
    end
  end

  def assert_dir(dir) do
    dirname = Path.join(@app_name, dir)
    assert_received {:mix_shell, :info, ["* creating " <> dirname]}
    assert(File.dir?(dirname), "#{dirname} doesn't exist")
  end

  def assert_file(file) do
    file_path = Path.join(@app_name, file)
    assert_received {:mix_shell, :info, ["* creating " <> file_path]}, "expected log message for creating #{file_path}"
    assert(File.regular?(file_path), "#{file_path} doesn't exist")
  end

  def assert_file_contains(file, contents) do
    assert_file(file)
    file_path = Path.join(@app_name, file)
    matches = file_path |> File.read! |> String.contains?(contents)
    assert(matches, "#{file_path} doesn't contain #{contents}. Contents are:\n#{File.read!(file_path)}")
  end

  test "it fails if directory name isn't provided" do 
    Mix.Tasks.Sherlock.New.run([])
    assert_received {:mix_shell, :error, ["A name is required."]}
  end

  test "it name is provided it will create a directory" do 
    Mix.Tasks.Sherlock.New.run(["my_board", "--dev"])
    assert_dir("my_board")
    assert_file_contains("mix.exs", "app: :my_board")
    assert_file("mix.lock")
    assert_file_contains("lib/my_board.ex", "defmodule MyBoard do\nend")
    assert_file("brunch-config.js")
    assert_file(".gitignore")
    assert_file("package.json")
    assert_file("config/config.exs")
    assert_file("config/dev.exs")
    assert_file("config/test.exs")
    assert_file("config/prod.exs")
    assert_file("jobs/html_job.ex")
    assert_file("jobs/event_job.ex")
    assert_file("dashboards/sample.html.eex")
    assert_file("widgets/number.vue")
    assert_file("widgets/htmlbox.vue")
    assert_file("widgets/deps.js")
    assert_file("yarn.lock")
    assert_file_contains("test/dashboard_test.exs", "defmodule MyBoard.DashboardTest do\n")
    assert_file_contains("test/support/integration_case.ex", "defmodule MyBoard.IntegrationCase do\n")
    assert_file("test/test_helper.exs")
  end
end
