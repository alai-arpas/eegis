defmodule Eegis.AgolAutorizza do
  use GenServer

  alias Eegis.Autentica

  @name __MODULE__

  ###########       CLIENT       ############################
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def app_env, do: Application.get_all_env(:eegis)

  def get_token(services, user) do
    GenServer.call(@name, {:get_token, services, user})
  end

  def get_table do
    GenServer.call(@name, :get_table)
  end

  def set_table_value do
    GenServer.call(@name, :set_table_value)
  end

  ###########       SERVER       ############################
  @impl true
  def init(_opts) do
    token_table = :ets.new(:token_table, [:set, :protected])
    {:ok, token_table}
  end

  @impl true
  def handle_call({:get_token, services, user}, _from, token_table) do
    IO.inspect({services, user}, label: "get for services, user:")
    my = :ets.lookup(token_table, {services, user})
    {:reply, my, token_table}
  end

  @impl true
  def handle_call(:get_table, _from, token_table) do
    {:reply, token_table, token_table}
  end

  def handle_call(:set_table_value, _from, token_table) do
    {pub, priv} = Autentica.elabora_user_srv()
    Enum.each(pub, fn p -> :ets.insert(token_table, p) end)
    Enum.each(priv, fn p -> :ets.insert(token_table, p) end)
    {:reply, token_table, token_table}
  end
end
