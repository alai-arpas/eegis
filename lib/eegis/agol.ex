defmodule Eegis.Agol do
  use GenServer

  @name __MODULE__

  ###########       CLIENT       ############################
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def get_users() do
    GenServer.call(@name, {:get_users})
  end

  ###########       SERVER       ############################
  @impl true
  def init(opts) do
    {:ok, opts}
  end

  @impl true
  def handle_call({:get_users}, _from, stato) do
    {:reply, stato, stato}
  end

  @impl true
  def handle_cast({:create}, _stato) do
    {:noreply, "solo per compilare"}
  end
end
