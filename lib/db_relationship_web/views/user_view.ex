defmodule DbRelationshipWeb.UserView do
  use DbRelationshipWeb, :view
  alias DbRelationshipWeb.UserView
  alias DbRelationshipWeb.PostView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("eager_show.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      age: user.age,
      posts: render_many(user.posts, PostView, "post.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      age: user.age}
  end
end
