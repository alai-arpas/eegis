defmodule Eegis.Agol do
  use GenServer

  @name __MODULE__

  ###########       CLIENT       ############################
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, app_env(), name: @name)
  end

  def app_env, do: Application.get_all_env(:eegis)

  def get_users() do
    GenServer.call(@name, {:get_users})
  end

  def get_services(user) do
    GenServer.call(@name, {:get_services, user})
  end

  defp utenti(stato) do
    Map.keys(stato[:app_users])
  end

  defp utenti(stato, utente) do
    users = stato[:app_users]
    Map.get(users, utente, :not_found)
  end

  ###########       SERVER       ############################
  @impl true
  def init(_opts) do
    {:ok, app_env()}
  end

  @impl true
  def handle_call({:get_services, user}, _from, stato) do
    IO.inspect(user, label: "feature services for user:")
    trovato = utenti(stato, user)
    url = trovato[:feature_services] <> "?f=pjson"

    {:ok, response} = Req.get(url)
    {:reply, response.body, stato}
  end

  @impl true
  def handle_call({:get_users}, _from, stato) do
    {:reply, utenti(stato), stato}
  end

  @impl true
  def handle_cast({:create, _name}, _stato) do
    {:noreply, "solo per compilare"}
  end
end
