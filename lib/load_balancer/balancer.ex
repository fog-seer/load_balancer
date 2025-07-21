defmodule LoadBalancer.Balancer do
  require Logger
  use GenServer

  def start_link(_opts) do
    Logger.alert("Running Balancer")

    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  defp build_balancer_map(configuration) do
    configuration
    |> Enum.flat_map(fn %{upstream_origins: ups, downstream_endpoints: downs} ->
      Enum.map(ups, fn origin -> {origin, downs} end)
    end)
    |> Map.new()
  end

  @impl true
  def init(_init) do
    {:ok, configuration} = Application.fetch_env(:load_balancer, :services)

    {:ok, build_balancer_map(configuration)}
  end

  @impl true
  def handle_call({:get_next, path}, _from, state) do
    endpoints = state[path]

    if endpoints == nil do
      {:reply, nil, state}
    else
      url = Enum.random(state[path])

      {:reply, url, state}
    end
  end
end
