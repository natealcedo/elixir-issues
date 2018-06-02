defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: escript_config(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false},
      {:hackney, github: "benoitc/hackney", override: true},
      {:httpoison, "~> 0.4"},
      {:jsx, "~> 2.0"}
    ]
  end

  defp escript_config do
    [main_module: Issues.CLI]
  end
end
