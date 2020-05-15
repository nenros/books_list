defmodule BooksListWeb.ArticleControllerTest do
  use BooksListWeb.ConnCase

  import BooksList.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_author]

    test "return 401 for not authorized user", %{conn: conn} do
      conn = get(conn, Routes.article_path(conn, :index))
      assert json_response(conn, 401)["errors"] == %{"detail" => "Unauthorized"}
    end

    test "return list of articles with author details", %{conn: conn, author: author} do
      author1 = insert(:author)
      insert_list(4, :article, author_id: author1.id)
      insert_list(2, :article, author_id: author.id)

      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> get(Routes.article_path(conn, :index))
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "create article" do
    setup [:create_author]

    test "renders article when data is valid", %{conn: conn, author: author} do
      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> post(Routes.article_path(conn, :create), article: string_params_for(:article))
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, author: author} do
      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> post(Routes.article_path(conn, :create), article: %{})
      assert json_response(conn, 400)["errors"] != %{body: ["can't be blank"], title: ["can't be blank"]}
    end

    test "don't allow create to not authorized user", %{conn: conn} do
      conn = conn
             |> post(Routes.article_path(conn, :create), article: %{})
      assert  %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end
  end

  describe "delete article" do
    setup [:create_article_with_author]

    test "delete article for not authorized should return error", %{conn: conn, article: article} do

      conn = delete(conn, Routes.article_path(conn, :delete, article))

      assert  %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end

    test "delete other user article return error", %{conn: conn, article: article} do
      author = insert(:author_with_token)

      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> delete(Routes.article_path(conn, :delete, article))

      assert  %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end

    test "deletes chosen article", %{conn: conn, article: article, author: author} do
      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> delete(Routes.article_path(conn, :delete, article))
      assert response(conn, 204)
    end
  end

  defp create_article_with_author(_) do
    author = insert(:author_with_token)
    article = insert(:article, author_id: author.id)
    %{article: article, author: author}
  end

  defp create_author(_) do
    author = insert(:author_with_token)
    %{author: author}
  end
end
