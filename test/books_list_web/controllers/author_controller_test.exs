defmodule BooksListWeb.AuthorControllerTest do
  use BooksListWeb.ConnCase

  import BooksList.Factory

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create author" do
    test "renders author when data is valid", %{conn: conn} do
      author_params = string_params_for(:author)
      conn = post(conn, Routes.author_path(conn, :create), author: author_params)

      assert token = get_resp_header(conn, "x-author-token")
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.author_path(conn, :create), author: %{})
      assert json_response(conn, 400)["errors"] != %{}
    end
  end

  describe "show author" do
    setup [:create_author]

    test "show author when authenticated", %{conn: conn, author: author} do
      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> get(Routes.author_path(conn, :show))

      assert %{"id" => id} = json_response(conn, 200)["data"]
    end

    test "return error when unathenticated", %{conn: conn} do
      conn = conn
             |> get(Routes.author_path(conn, :show))

      assert  %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end

  end

  describe "update author" do
    setup [:create_author]

    test "allow to update author when authenticated" , %{conn: conn, author: author} do
      author_params = string_params_for(:author, first_name: "New first name")

      conn = conn
             |> put_req_header("x-author-token", author.token)
             |> put(Routes.author_path(conn, :update), author: author_params)

      assert %{"id" => id} = json_response(conn, 200)["data"]
    end

    test "return error when unathenticated", %{conn: conn} do
      author_params = string_params_for(:author, first_name: "New first name")

      conn = conn
             |> put(Routes.author_path(conn, :update), author: author_params)

      assert  %{"detail" => "Unauthorized"} = json_response(conn, 401)["errors"]
    end

  end

  defp create_author(_) do
    author = insert(:author_with_token)
    %{author: author}
  end

end
