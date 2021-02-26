defmodule DbRelationship.Repo do
  use Ecto.Repo,
    otp_app: :db_relationship,
    adapter: Ecto.Adapters.Postgres
end
