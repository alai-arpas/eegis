alias Eegis.Env

alias Eegis.ClientExample.AppCarg539Legenda, as: Eac_leg
alias Eegis.ClientExample.AppCarg539Campioni, as: Eac_camp



query = %Eegis.Arcgis.Query{
  base_url: "https://geoportale.arpasambiente.it/server/rest/services/Hosted/CARG_colori/FeatureServer/2/query",
  where: "1=1",
  out_fields: "*",
  return_geometry: true
}

{:ok, response} = Eegis.Arcgis.Client.request(query)

#IO.inspect(response.body, label: "Risultato ArcGIS")
