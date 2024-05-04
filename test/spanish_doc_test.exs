defmodule SpanishDocTest do
  use ExUnit.Case
  doctest SpanishDoc

  test "the String.Chars protocol with a NIF" do
    {:ok, _type, nif} = SpanishDoc.parse("16659622D")
    assert to_string(nif) == "16659622D"
  end

  test "the String.Chars protocol with a legal NIF" do
    {:ok, _type, nif} = SpanishDoc.parse("E90725946")
    assert to_string(nif) == "E90725946"
  end

  test "the String.Chars protocol with a lowercased NIE" do
    {:ok, _type, nie} = SpanishDoc.parse("y7136855s")
    assert to_string(nie) == "Y7136855S"
  end

  test "Ecto.Changeset usings SpanishDoc.EctoType returns an error for invalid data" do
    types = %{field: SpanishDoc.EctoType}
    changeset = Ecto.Changeset.cast({%{}, types}, %{field: "world"}, [:field])
    refute changeset.valid?
  end

  test "Ecto.Changeset usings SpanishDoc.EctoType returns a parsed field for valid data" do
    types = %{field: SpanishDoc.EctoType}
    changeset = Ecto.Changeset.cast({%{}, types}, %{field: "y7136855s"}, [:field])
    assert {:ok, "Y7136855S"} == Ecto.Changeset.fetch_change(changeset, :field)
    assert changeset.valid?
  end
end
