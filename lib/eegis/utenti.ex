defmodule Eegis.Utenti do
  @moduledoc """
  Gestisce gli utenti
  Le informazioni derivano dalle variabili d'ampiente
  :eegis, :app_users
  """

  def all, do: Application.get_env(:eegis, :app_users)

  @doc """
  Il nome di tutti gli utenti
  """
  @spec all_name :: list
  def all_name, do: Map.keys(all())

  @doc """
  Utenti che possono essere autenticati
  con :app_id, :app_secret
  """
  def to_authorize do
    all()
    |> Map.to_list()
    |> Enum.filter(fn {_k, v} -> Map.get(v, :auth) end)
    |> Enum.into(%{})
  end

  def trova_utente(user) do
    to_authorize()
    |> Map.get(user)
  end

  # def get_app_and_secret(user) do
  #   case to_authorize() do

  #   end

  # end
end
