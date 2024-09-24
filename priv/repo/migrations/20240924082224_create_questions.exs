defmodule Pento.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :answer, :string
      add :votes, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
