defmodule DbRelationshipWeb.UserController do
  use DbRelationshipWeb, :controller

  alias DbRelationship.Accounts
  alias DbRelationship.Accounts.User

  action_fallback DbRelationshipWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  @doc "
    Загрузка записи User без записи Post
  "
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  @doc "
    Жадная загрузка записи User со всеми записями Post
  "
  def eager_show(conn, %{"id" => id}) do
    {:ok, user} = Accounts.eager_get_user(id)
    render(conn, "eager_show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

end
