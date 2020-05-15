defmodule BooksList.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: BooksList.Repo


  def author_factory do
    %BooksList.Authors.Author{
      age: 18,
      first_name: sequence(:name, &"Name#{&1}"),
      last_name: sequence(:last_name, &"Lastname#{&1}")
    }
  end

  def article_factory do
    %BooksList.Authors.Article{
      title: sequence(:title, &"Title#{&1}"),
      description: sequence(:description, &"Description#{&1}"),
      body: sequence(:body, &"Body#{&1}"),
    }
  end

  def author_with_token_factory do
    struct!(
      author_factory(),
      %{
        token: Ecto.UUID.generate()
      }
    )
  end
end
