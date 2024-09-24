defmodule Pento.FAQ.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    field :answer, :string
    field :votes, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :answer, :votes])
    |> validate_required([:question, :answer, :votes])
  end
end
