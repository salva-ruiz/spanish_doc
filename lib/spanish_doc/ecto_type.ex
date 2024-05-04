defmodule SpanishDoc.EctoType do
  @moduledoc """
  Implements a custom `Ecto.Type` for use in `Ecto.Schema` modules.

  ## Example:

      schema "my_schema" do
        field :nif_document, SpanishDoc.EctoType
        ...
      end
  """

  use Ecto.Type

  @impl true
  def type, do: :string

  @impl true
  def cast(value) when is_binary(value) do
    case SpanishDoc.parse(value) do
      {:ok, _type, parsed_value} ->
        {:ok, parsed_value}

      {:error, _reason} ->
        :error
    end
  end

  def cast(_), do: :error

  @impl true
  def dump(value) when is_binary(value), do: {:ok, value}
  def dump(_), do: :error

  @impl true
  def load(value), do: {:ok, value}
end
