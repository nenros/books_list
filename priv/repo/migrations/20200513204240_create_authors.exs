defmodule BooksList.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
      add :token, :uuid

      timestamps()
    end

  end
end
