defmodule Eegis.Arcgis.Query do
  @moduledoc """
  Rappresenta una query ArcGIS FeatureServer.
  """

  defstruct [
    # es: "https://geoportale.arpasambiente.it/server/rest/services/Hosted/CARG_colori/FeatureServer/2/query"
    :base_url,
    where: "1=1",
    out_fields: "*",
    return_geometry: true,
    geometry: nil,
    geometry_type: "esriGeometryEnvelope",
    spatial_rel: "esriSpatialRelIntersects",
    result_offset: nil,
    result_record_count: nil,
    # oppure "json"
    format: "pjson"
  ]

  def new() do
    %__MODULE__{}
  end
end
