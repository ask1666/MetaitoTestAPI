# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :my_app,
  ecto_repos: [MyApp.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :my_app, MyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f19xOIW0QvDm+jY6FSZutpEDY10iMRW3e76JGfQQsqLUtoQoXOujJB8lgK3BexTi",
  render_errors: [view: MyAppWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MyApp.PubSub,
  live_view: [signing_salt: "JN47taR1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  origin: ["http://localhost:8080"],
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH", "HEAD"]

config :pbkdf2_elixir, :rounds, 1
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
