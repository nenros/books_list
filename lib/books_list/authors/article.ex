defmodule BooksList.Authors.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :body, :string
    field :description, :string
    field :title, :string

    belongs_to :author, BooksList.Authors.Author

    timestamps(inserted_at: :published_date)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body])
    |> validate_required([:title, :body])
    |> validate_length(:title, max: 150)
  end
end
