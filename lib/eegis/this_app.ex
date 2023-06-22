defmodule Eegis.ThisApp do
  alias Eegis.ThisApp
  use GenServer

  ## Missing Client API - will add this later
  def start_link(_opts) do
    ThisApp.init(:ok)
  end

  def chiama do
    "si"
  end

  ## Defining GenServer Callbacks

  @impl true
  def init(_opts) do
    {:ok, self()}
  end

  @impl true
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  @impl true
  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      # {:ok, bucket} = KV.Bucket.start_link([])
      # {:noreply, Map.put(names, name, bucket)}
      {:noreply, "solo per compilare"}
    end
  end
end
