defmodule LoadBalancer.MixProject do
  use Mix.Project

  def project do
    [
      app: :load_balancer,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {LoadBalancer.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.7.0"},
      {:req, "~> 0.5.10"}
    ]
  end
end
