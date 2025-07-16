defmodule BlogApiWeb.PostController do
  use BlogApiWeb, :controller

  alias BlogApi.Content
  alias BlogApi.Content.Post

  action_fallback BlogApiWeb.FallbackController

  # Ação para listar todos os posts.
  def index(conn, _params) do
    posts = Content.list_posts()
    render(conn, :index, posts: posts)
  end

  # Ação para criar um post.
  def create(conn, %{"post" => post_params, "user_id" => user_id}) do
    post_params = Map.put(post_params, "user_id", user_id)

    case Content.create_post(post_params) do
      {:ok, post} ->
        render(conn, :show, post: post)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :error, changeset: changeset)
    end
  end

  # Ações para mostrar, atualizar e deletar um post.
  def show(conn, %{"id" => id}) do
    post = Content.get_post!(id)
    render(conn, :show, post: post)
  end

  # Ação para atualizar um post.
  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Content.get_post!(id)

    with {:ok, %Post{} = post} <- Content.update_post(post, post_params) do
      render(conn, :show, post: post)
    end
  end

  # Ação para deletar um post.
  def delete(conn, %{"id" => id}) do
    post = Content.get_post!(id)

    with {:ok, %Post{}} <- Content.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
