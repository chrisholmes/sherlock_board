defmodule ExampleDashboard.Mixfile do
  use Mix.Project

  def project do
    [app: :example_dashboard,
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [ 
      applications: [:sherlock_board, :phoenix, :phoenix_html, :cowboy, :logger, :gettext]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix, "~> 1.2"},
      {:sherlock_board, path: '../'},
      {:hound, "~> 1.0", only: :test}
    ]
  end
end
