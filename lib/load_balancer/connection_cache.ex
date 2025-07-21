defmodule LoadBalancer.ConnectionCache do
  require Logger
  use GenServer

  def start_link(opts \\ []) do
    Logger.alert("Running connection cache")

    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(_init) do
    {:ok, []}
  end
end
