# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :db_relationship,
  ecto_repos: [DbRelationship.Repo]

# Configures the endpoint
config :db_relationship, DbRelationshipWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CbN2TyxKHQ5S7UzgcXmJaBwTsgPPzL9Su6vt4ksBxHCc52GpJjOJ9xYOAR6/MJ7l",
  render_errors: [view: DbRelationshipWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DbRelationship.PubSub,
  live_view: [signing_salt: "stjsWWP+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
