defmodule DbRelationship.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      DbRelationship.Repo,
      # Start the Telemetry supervisor
      DbRelationshipWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DbRelationship.PubSub},
      # Start the Endpoint (http/https)
      DbRelationshipWeb.Endpoint
      # Start a worker by calling: DbRelationship.Worker.start_link(arg)
      # {DbRelationship.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DbRelationship.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DbRelationshipWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
