defmodule Eegis.Env do
  @doc """
  Restituisce una keyword list
  """

  def all, do: Application.get_all_env(:eegis)
  def keys, do: all() |> Keyword.keys()

  def key_map(key, mapKey) do
    all()
    |> Keyword.get(key)
    |> Map.get(mapKey, :not_found)
  end

  @spec app(atom) :: map() | :not_found
  def app(an_app), do: key_map(:apps, an_app)

  def apps_name, do: all()[:apps] |> Map.keys()
  def user_services_name, do: all()[:user_services] |> Map.keys()
end
