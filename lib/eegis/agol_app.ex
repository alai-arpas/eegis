defmodule Eegis.AgolApp do
  @moduledoc """
  Definisce le funzioni necessarie per una applicazione
  Agol(ArcGis On Line)

  Nell'applicazione client inserire:
      use Eegis.AgolApp

  e sovrascrivere il nome dell'applicazione

      def app_name, do: :nome_applicazione

  Il nome dell'applicazione viene configurato in config/*.exs files
  """

  alias Eegis.Env
  alias Eegis.AgolAutorizza, as: AgolAuth
  alias Eegis.HttpRequest, as: HttpReq

  @type nome_feature :: atom()

  @doc """
  Da sovrascrivere nell'applicazione client:
      def app_name, do: :carg_539

  Vedi applicazione esempio in `Eegis.ClientExample.AppCarg539`
  """
  @callback app_name :: atom()

  @doc """
  Vedi applicazione esempio in `Eegis.ClientExample.AppCarg539.features_usr_srv`
  """
  @callback features_usr_srv :: map()

  @doc """
  Vedi applicazione esempio in `Eegis.ClientExample.AppCarg539.get_features_desc`
  """
  @callback get_features_desc :: map()

  @doc """
  Vedi applicazione esempio in `Eegis.ClientExample.AppCarg539.get_a_feature_desc`
  """
  @callback get_a_feature_desc(nome_feature) :: map()

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      def app_name, do: :my_app_name

      defp downcase(mappa), do: Enum.map(mappa, fn {k, v} -> {String.downcase(k), v} end)

      @doc """
      Estrae da config/*.exs per l'applicazione corrente(appname()) `:features_usr_srv`
          %{
            {:alai, :arpas} => %{
              carg_539_campioni: %{nome: "MOGORO_539", numero: 1},
              carg_539_igm: %{nome: "MOGORO_539", numero: 3},
              carg_539_legenda: %{nome: "MOGORO_539", numero: 4}
            },
            {:guest, :esri_lab} => %{lsgv1: %{nome: "Live_Stream_Gauges_v1", numero: 0}}
          }
      """
      def features_usr_srv, do: Env.app(app_name())[:features_usr_srv]

      # passo 1a in "get_features_desc"
      defp assembla_feature_usrsrv({nome_atom, fea_desc}, usr_srv) do
        {nome_atom, Map.put(fea_desc, :usr_srv, usr_srv)}
      end

      # passo 1 in "get_features_desc"
      defp estrai_fea_user({usr_srv, features}) do
        Enum.map(features, &assembla_feature_usrsrv(&1, usr_srv))
      end

      # passo 2 in "get_features_desc"
      defp valori_auth(desc_feature) do
        {usr_srv, dato} = AgolAuth.get_token(desc_feature[:usr_srv]) |> hd
        fs = Map.get(dato, :feature_srv)
        dtoken = Map.get(dato, :token)

        attrs =
          if dtoken do
            %{"token=" => Map.get(dtoken, "access_token")}
          else
            %{}
          end

        Map.put(desc_feature, :feature_srv, fs)
        |> Map.put(:attrs, attrs)
      end

      @doc """
      Per tutte le feature crea una chiave:(nome_feature)
      porzione di esempio:
          %{
            carg_539_legenda: %{
              feature_srv: "https://servicesX.arcgis.com/yyyyyyyyyyyyyyyy/",
              nome: "MOGORO_539",
              numero: 2,
              usr_srv: {:alai, :arpas},
              attrs: %{
                "token=" => "molti caratteri 1YyrqfW4A.."
              }
            }
          }
      """
      def get_features_desc() do
        features =
          features_usr_srv()
          |> Enum.flat_map(&estrai_fea_user/1)
          |> Enum.map(fn {k, desc_feat} -> {k, valori_auth(desc_feat)} end)
          |> Enum.into(%{})
      end

      @doc """
      Usa `get_features_desc` per estrarre una "Singola" feature

      """
      def get_a_feature_desc(atom_name), do: Map.get(get_features_desc(), atom_name)

      @doc """
      Unisce l'ulr con i parametri &stringa_1=valore_1&stringa_2=valore_2
      """
      def url_string(url, params) do
        {:ok, uri} = URI.new(url)

        parametri =
          params
          |> Enum.map(fn {k, v} -> k <> v end)
          |> Enum.join("&")

        URI.append_query(uri, parametri)
        |> URI.to_string()
      end

      @doc """
      Aggiorna una lista di features
      """
      def update_features(atom_name, features \\ [%{}]) do
        desc = get_a_feature_desc(atom_name)

        params = %{"f" => "pjson"}
        headers = Map.get(desc, :attrs)
        token = Map.get(headers, "token=")
        params = Map.merge(params, %{"token" => token})

        fs = Map.get(desc, :feature_srv)
        nome = Map.get(desc, :nome)
        numero = Map.get(desc, :numero)

        url = "#{fs}arcgis/rest/services/#{nome}/FeatureServer/#{numero}/updateFeatures"
        HttpReq.post_request(url, params, features)
      end

      @doc """
      Ottine una lista di record per una specifica features
      restiutendo:
          {solo_attributi, fields}
      """
      def get_a_feature(atom_name, attrs \\ %{}) do
        default = %{"outFields=" => "*", "f=" => "pjson", "where=" => "1=1"}

        desc = get_a_feature_desc(atom_name)

        headers = Map.get(desc, :attrs)
        params = Map.merge(default, attrs)
        params = Map.merge(params, headers)

        fs = Map.get(desc, :feature_srv)
        nome = Map.get(desc, :nome)
        numero = Map.get(desc, :numero)

        url = "#{fs}arcgis/rest/services/#{nome}/FeatureServer/#{numero}/query"
        stringa_url = url_string(url, params)

        IO.inspect(stringa_url, label: "url")

        {:ok, response} = Req.get(stringa_url)

        features = Map.get(response.body, "features")
        solo_attributi = Enum.map(features, fn v -> Map.get(v, "attributes") end)
        fields = Map.get(response.body, "fields")
        {solo_attributi, fields}
      end

      @doc """
      Get user servizo
      """
      def get_usr_srv() do
        features_usr_srv()
        |> Map.keys()
      end

      defoverridable app_name: 0
    end
  end
end
