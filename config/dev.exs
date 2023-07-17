import Config

# queste variabili sono usate per testare l'applicazione
# :eegis in locale
# la configurazione deve essere ripetuta quando si usa :eegis come libreria
#

app_id = System.get_env("ESRI_APP_id") || ""
app_secret = System.get_env("ESRI_APP_secret") || ""
fs = System.get_env("ESRI_ARPAS_SERVICES") || ""

# esempi di esri - potrebbe non funzionare
esri_feature_services_examples = "https://services9.arcgis.com/RHVPKKiFTONKtxq3/"

# per i test usiamo sempre lo stesso utente

logged_user = %{app_id: app_id, app_secret: app_secret, feature_srv: fs, public: false}
non_logged_user = %{feature_srv: esri_feature_services_examples, public: true}

config :eegis,
  da_config_app: "eegis_dev.exs",
  apps: %{
    carg_539: %{
      features_usr_srv: %{
        {:alai, :arpas} => %{
          carg_539_campioni: %{nome: "MOGORO_539", numero: 1},
          carg_539_igm: %{nome: "MOGORO_539", numero: 3},
          carg_539_legenda: %{nome: "MOGORO_539", numero: 4}
        },
        {:guest, :esri_lab} => %{
          lsgv1: %{nome: "Live_Stream_Gauges_v1", numero: 0}
        }
      }
    },
    esri_lab: %{
      features: [:lsgv1]
    }
  },
  user_services: %{
    {:alai, :arpas} => logged_user,
    {:guest, :esri_lab} => non_logged_user
  }
