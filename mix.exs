defmodule BitcoinAddress.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bitcoin_address,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Bitcoin tools and full node implementation in Elixir.
      {:bitcoin, "~> 0.0.2"},
      # A static code analysis tool for the Elixir language
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      # Interface C-code with Erlang/Elixir using Ports
      {:cure, "~> 0.5.0"},
      # A code style linter for Elixir, powered by shame
      {:dogma, "~> 0.1", only: [:dev, :test]},
      # Erlport wrapper for Elixir to interface with Python code
      {:export, "~> 0.1.0"},
      # Automatically run your Elixir project's tests each time you save a file
      {:mix_test_watch, "~> 0.3", only: :dev, runtime: false}
    ]
  end
end
