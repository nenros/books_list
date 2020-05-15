defmodule BooksList.AuthorsTest do
  use BooksList.DataCase
  import BooksList.Factory

  alias BooksList.Authors

  describe "authors" do
    alias BooksList.Authors.Author

    test "get_author!/1 returns the author with given id" do
      author = insert(:author)
      assert Authors.get_author!(author.id) == author
    end

    test "get_author_by_token!/1 returns the author with given token" do
      author = insert(:author_with_token)
      assert Authors.get_author_by_token!(author.token) == author
    end

    test "create_author/1 with valid data creates a author" do
      author_params = params_for(:author)
      assert {:ok, %Author{} = author} = Authors.create_author(author_params)
      assert author.age == author_params[:age]
      assert author.first_name == author_params[:first_name]
      assert author.last_name == author_params[:last_name]
      refute author.token == nil
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authors.create_author(params_for(:author, age: 10))
    end

    test "author first name cannot be empty" do
      assert {:error, changeset} = Authors.create_author(params_for(:author, first_name: nil))
      assert %{first_name: ["can't be blank"]} = errors_on(changeset)
    end

    test "author last name cannot be empty" do
      assert {:error, changeset} = Authors.create_author(params_for(:author, last_name: nil))
      assert %{last_name: ["can't be blank"]} = errors_on(changeset)
    end

    test "author age cannot be empty" do
      assert {:error, changeset} = Authors.create_author(params_for(:author, age: nil))
      assert %{age: ["can't be blank"]} = errors_on(changeset)
    end

    test "author age must be grather or equal 13" do
      assert {:error, changeset} = Authors.create_author(params_for(:author, age: Enum.random(0..12)))
      assert %{age: ["must be greater than or equal to 13"]} = errors_on(changeset)
    end

    test "update_author/2 with valid data updates the author" do
      author = insert(:author)
      params_to_update = params_for(:author, age: 43, first_name: "some updated first_name", last_name: "some updated last_name")
      assert {:ok, %Author{} = author} = Authors.update_author(author, params_to_update)
      assert author.age == params_to_update[:age]
      assert author.first_name == params_to_update[:first_name]
      assert author.last_name == params_to_update[:last_name]
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = insert(:author)
      params_to_update = params_for(:author, age: 10)
      assert {:error, %Ecto.Changeset{}} = Authors.update_author(author, params_to_update)
      assert author == Authors.get_author!(author.id)
    end

    test "change_author/1 returns a author changeset" do
      author = build(:author)
      assert %Ecto.Changeset{} = Authors.change_author(author)
    end
  end

  describe "articles" do
    alias BooksList.Authors.Article

    test "list_articles/0 returns list of articles with authors" do
      article_numbers = 10
      author = insert(:author)
      insert_list(article_numbers, :article, author_id: author.id)
      articles = Authors.list_articles()
      assert article_numbers == length(articles)
    end

    test "list_articles_with_author_details/0 returns list of articles with authors" do
      article_numbers = 10
      author = insert(:author)
      insert_list(article_numbers, :article, author_id: author.id)
      articles = Authors.list_articles_with_author_details()
      assert article_numbers == length(articles)
      assert true = Enum.all?(articles, fn(article = %Article{})-> article.author != nil end)
    end
#
#    @valid_attrs %{body: "some body", description: "some description", published_date: "2010-04-17T14:00:00Z", title: "some title"}
#    @update_attrs %{body: "some updated body", description: "some updated description", published_date: "2011-05-18T15:01:01Z", title: "some updated title"}
#    @invalid_attrs %{body: nil, description: nil, published_date: nil, title: nil}
#
#    def article_fixture(attrs \\ %{}) do
#      {:ok, article} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Authors.create_article()
#
#      article
#    end

#    test "create_article/1 with valid data creates a article" do
#      assert {:ok, %Article{} = article} = Authors.create_article(@valid_attrs)
#      assert article.body == "some body"
#      assert article.description == "some description"
#      assert article.published_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
#      assert article.title == "some title"
#    end
#
#    test "create_article/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Authors.create_article(@invalid_attrs)
#    end
#
#    test "update_article/2 with valid data updates the article" do
#      article = article_fixture()
#      assert {:ok, %Article{} = article} = Authors.update_article(article, @update_attrs)
#      assert article.body == "some updated body"
#      assert article.description == "some updated description"
#      assert article.published_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
#      assert article.title == "some updated title"
#    end
#
#    test "update_article/2 with invalid data returns error changeset" do
#      article = article_fixture()
#      assert {:error, %Ecto.Changeset{}} = Authors.update_article(article, @invalid_attrs)
#      assert article == Authors.get_article!(article.id)
#    end
#
#    test "delete_article/1 deletes the article" do
#      article = article_fixture()
#      assert {:ok, %Article{}} = Authors.delete_article(article)
#      assert_raise Ecto.NoResultsError, fn -> Authors.get_article!(article.id) end
#    end

    test "change_article/1 returns a article changeset" do
      article = build(:article)
      assert %Ecto.Changeset{} = Authors.change_article(article)
    end
  end
end
