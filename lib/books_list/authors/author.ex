defmodule BooksList.Authors.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias BooksList.Authors.Article

  schema "authors" do
    field :age, :integer
    field :first_name, :string
    field :last_name, :string
    field :token, Ecto.UUID

    has_many :articles, Article

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:first_name, :last_name, :age])
    |> validate_required([:first_name, :last_name, :age])
    |> validate_number(:age, greater_than_or_equal_to: 13)
  end

  def create_changeset(author, attrs) do
    author
    |> changeset(attrs)
    |> put_token
  end

  defp put_token(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :token, Ecto.UUID.generate())
      _ -> changeset
    end
  end

end
