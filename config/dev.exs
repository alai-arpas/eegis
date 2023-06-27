import Config

# queste variabili sono usate per testare l'applicazione
# :eegis in locale
# la configurazione deve essere ripetuta quando si usa :eegis come libreria
#

app_id = System.get_env("ESRI_APP_id") || ""
app_secret = System.get_env("ESRI_IDRO_APP_id") || ""
fs = System.get_env("ESRI_SERVICES") || ""

# esempi di esri - potrebbe non funzionare
esri_feature_services_examples =
  "https://services9.arcgis.com/RHVPKKiFTONKtxq3/ArcGIS/rest/services"

# per i test usiamo sempre lo stesso utente
logged_user = %{auth: true, app_id: app_id, app_secret: app_secret, feature_services: fs}

agol_url =
  config :eegis,
    da_config_app: "dev.exs",
    app_users: %{
      logged_user: logged_user,
      lg1: logged_user,
      lg2: logged_user,
      guest: %{auth: false, feature_services: esri_feature_services_examples},
      guest_esri: %{auth: false, feature_services: esri_feature_services_examples}
    }
