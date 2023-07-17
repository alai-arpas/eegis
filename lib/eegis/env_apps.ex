defmodule Eegis.EnvApps do
  alias Eegis.Env

  def get_features(atom_app) do
    Env.app(atom_app)[:features_usr_srv]
  end

  def get_users(atom_app) do
    Env.app(atom_app)[:features_usr_srv]
    |> Map.keys()
  end
end
