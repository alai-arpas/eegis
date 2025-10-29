defmodule Eegis.Arcgis.Client do
  def request(%Eegis.Arcgis.Query{base_url: url} = query) do
    params = Eegis.Arcgis.Request.to_params(query)

    Req.get(url, params: params)
  end
end
