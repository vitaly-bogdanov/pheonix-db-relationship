defmodule DbRelationshipWeb.PostController do
  use DbRelationshipWeb, :controller

  alias DbRelationship.Articles
  alias DbRelationship.Articles.Post

  action_fallback DbRelationshipWeb.FallbackController

  def index(conn, _params) do
    posts = Articles.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def eager_index do
    posts = Articles.list_posts_with_user

    IO.inspect posts
  end

  def create(conn, params) do
    with {:ok, %Post{} = post} <- Articles.create_post(params) do
      conn
      |> put_status(201)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> json(%{title: post.title, body: post.body})
    end
  end

  def show(conn, %{"id" => id}) do
    post = Articles.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Articles.get_post!(id)

    with {:ok, %Post{} = post} <- Articles.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Articles.get_post!(id)

    with {:ok, %Post{}} <- Articles.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
