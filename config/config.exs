import Config

config :eegis,
  da_config_app: "config.exs"

import_config "#{config_env()}.exs"
