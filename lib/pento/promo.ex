defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient, attrs) do
    case change_recipient(recipient, attrs) do
      %Ecto.Changeset{valid?: true} ->
        {:ok, "Sending email..."}

      %Ecto.Changeset{} = changeset ->
        {:error, changeset}
    end
  end
end
