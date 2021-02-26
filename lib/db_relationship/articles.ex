defmodule DbRelationship.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias DbRelationship.Repo

  alias DbRelationship.Articles.Post
  alias DbRelationship.Accounts.User

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  def list_posts_with_user do
    Repo.transaction fn ->
      Repo.all(Post) |> Repo.preload(:user)
    end
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
    Создаем пост и привязываем к нему юзера
  """
  def create_post(%{"user_id" => user_id, "post" => %{"title" => title, "body" => body}}) do
    Repo.transaction fn ->
      User
      |> Repo.get!(user_id)
      |> Ecto.build_assoc(:posts, %{title: title, body: body})
      |> Repo.insert!
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
