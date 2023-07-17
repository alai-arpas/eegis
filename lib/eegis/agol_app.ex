defmodule Eegis.AgolApp do
  @moduledoc """
  Agol application
  """
  alias Eegis.Env
  alias Eegis.AgolAutorizza, as: AgolAuth

  @callback app_name :: atom()

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      def app_name, do: :my_app_name

      @doc """
      """

      def features_usr_srv, do: Env.app(app_name())[:features_usr_srv]
      # uno
      defp assembla_feature_usrsrv({nome_atom, fea_desc}, usr_srv) do
        {nome_atom, Map.put(fea_desc, :usr_srv, usr_srv)}
      end

      # due
      defp estrai_fea_user({usr_srv, features}) do
        Enum.map(features, &assembla_feature_usrsrv(&1, usr_srv))
      end

      # tre
      defp valori_auth(desc_feature) do
        {usr_srv, dato} = AgolAuth.get_token(desc_feature[:usr_srv]) |> hd
        # IO.inspect(dato, label: "dato")
        fs = Map.get(dato, :feature_srv)
        dtoken = Map.get(dato, :token)

        headers =
          if dtoken do
            %{:token => Map.get(dtoken, "access_token")}
          else
            %{}
          end

        Map.put(desc_feature, :feature_srv, fs)
        |> Map.put(:headers, headers)
      end

      def get_features_desc() do
        features =
          features_usr_srv()
          |> Enum.flat_map(&estrai_fea_user/1)
          |> Enum.map(fn {k, desc_feat} -> {k, valori_auth(desc_feat)} end)
          |> Enum.into(%{})
      end

      def get_a_feature_desc(atom_name) do
        Map.get(get_features_desc(), atom_name)
      end

      def get_a_feature(atom_name, fields \\ "*", where \\ "1=1") do
        desc = get_a_feature_desc(atom_name)
        fs = Map.get(desc, :feature_srv)
        nome = Map.get(desc, :nome)
        numero = Map.get(desc, :numero)
        headers = Map.get(desc, :headers)
        stringa_headers = "token=" <> Map.get(headers, :token)
        url = "#{fs}arcgis/rest/services/#{nome}/FeatureServer/#{numero}/query"
        {:ok, uri} = URI.new(url)

        uri
        |> URI.append_query("where=" <> where)
        |> URI.append_query("outFields=" <> fields)
        |> URI.append_query("f=pjson")
        |> URI.append_query(stringa_headers)
        |> URI.to_string()
      end

      def get_usr_srv() do
        features_usr_srv()
        |> Map.keys()
      end

      defoverridable app_name: 0
    end
  end
end
