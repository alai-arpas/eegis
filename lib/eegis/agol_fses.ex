defmodule Eegis.AgolFses do
  alias Eegis.HttpRequest, as: HttpReq

  @moduledoc """
  Agol Feature services
  """

  @callback srv :: String.t()
  @callback user :: term

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      def admin_url, do: "#{srv()}ArcGIS/admin/rest/services"
      def rest_url, do: "#{srv()}ArcGIS/rest/services"

      def get_features(nome, numero) do
        url = rest_url() <> "/#{nome}/FeatureServer/#{numero}?f=pjson"
        IO.inspect(url, label: "url")
        HttpReq.get(url)
      end

      def user, do: :guest
      def srv, do: "https://service9.arcgis.com/RHVPKKiFTONKtxq3/"

      defoverridable(srv: 0, user: 0)
    end
  end
end
