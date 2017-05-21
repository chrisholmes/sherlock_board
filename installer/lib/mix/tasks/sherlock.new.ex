defmodule Mix.Tasks.Sherlock.New do
  use Mix.Task
  import Mix.Generator
  require EEx

  @files [
    eex: [
      "mix.exs",
      "brunch-config.js",
      "lib/<%= name %>.ex",
      "test/dashboard_test.exs",
      "test/support/integration_case.ex",
    ],
    text: [ 
      "package.json",
      "mix.lock",
      "yarn.lock",
      ".gitignore",
      "config/config.exs",
      "config/dev.exs",
      "config/test.exs",
      "config/prod.exs",
      "jobs/html_job.ex",
      "jobs/event_job.ex",
      "dashboards/sample.html.eex",
      "test/test_helper.exs",
      "widgets/number.vue",
      "widgets/htmlbox.vue",
      "widgets/deps.js"
    ]
  ]

  @shortdoc "Generates a new sherlock dashboard"
  def run([]) do
    Mix.shell.error("A name is required.")
  end

  @shortdoc "Generates a new sherlock dashboard"
  def run(args) do
    [name | options ] = args
    create_directory(name)
    Enum.each(@files[:eex], fn(file) ->
      content = template_dir |> Path.join(file <> ".eex") |> File.read!
      create_file(Path.join(name, eval_with_options(file, args)), eval_with_options(content, args))
    end)

    Enum.each(@files[:text], fn(file) ->
      content = template_dir |> Path.join(file) |> File.read!
      create_file(Path.join(name, file), content)
    end)

    if Mix.shell.yes?(~s[Fetch and install dependencies?]) do
      File.cd!(name, fn-> 
       Mix.shell.cmd("mix deps.get")
       Mix.shell.cmd("yarn install && node_modules/brunch/bin/brunch build")
      end)
    end
  end

  defp eval_with_options(string, [name | options]) do
    bindings = [ name: name ] ++ dev_bindings(options)
    EEx.eval_string(string, bindings)
  end

  defp dev_bindings([]) do
    [
      sherlock_dep: "{:sherlock_board, '0.1.0'}",
      sherlock_path: "deps/sherlock_board"
    ]
  end

  defp dev_bindings(["--dev" | _]) do
     [
       sherlock_dep: ~s[{:sherlock_board, path: "#{sherlock_dev_path}", override: true}],
       sherlock_path: sherlock_dev_path
     ]
  end

  defp sherlock_dev_path do
    Path.expand("../../../../", Path.dirname(__ENV__.file))
  end

  defp template_dir do
    Path.expand("../../../templates", Path.dirname(__ENV__.file))
  end
end
