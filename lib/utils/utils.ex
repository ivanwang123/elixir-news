defmodule SocialMediaV3.Utils do
  def create_alert(msg, error) do
    %{alert: %{msg: msg, error: error}}
  end

  def get_error_msg(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, _opts} -> msg end)
    |> Enum.reduce("", fn {_key, value}, _acc ->
      hd(value)
    end)
  end
end
