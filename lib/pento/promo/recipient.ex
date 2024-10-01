defmodule Pento.Promo.Recipient do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__
  @primary_key false

  embedded_schema do
    field :first_name, :string
    field :email, :string
  end

  def changeset(%Recipient{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :email])
    |> validate_required([:first_name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
