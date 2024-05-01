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
end
