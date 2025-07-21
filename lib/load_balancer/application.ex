defmodule LoadBalancer.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LoadBalancer.ConnectionCache,
      LoadBalancer.Balancer,
      {Bandit, plug: LoadBalancer.Router}
    ]

    opts = [strategy: :one_for_one, name: LoadBalancer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
