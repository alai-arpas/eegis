defmodule Eegis.Arcgis.Request do
  @doc """
  Converte una %ArcGIS.Query{} in mappa parametri da passare a Req.
  """

  def to_params(q) do
    %{
      "where" => q.where,
      "outFields" => q.out_fields,
      "returnGeometry" => q.return_geometry,
      "geometry" => q.geometry,
      "geometryType" => q.geometry_type,
      "spatialRel" => q.spatial_rel,
      "resultOffset" => q.result_offset,
      "resultRecordCount" => q.result_record_count,
      "f" => q.format
    }
    # rimuove i nil
    |> Enum.reject(fn {_k, v} -> is_nil(v) end)
    |> Enum.into(%{})
  end
end
