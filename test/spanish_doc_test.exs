defmodule SpanishDocTest do
  use ExUnit.Case
  doctest SpanishDoc

  test "the String.Chars protocol" do
    {:ok, _type, nif} = SpanishDoc.parse("16659622D")
    assert to_string(nif) == "16659622D"

    {:ok, _type, nif} = SpanishDoc.parse("E90725946")
    assert to_string(nif) == "E90725946"

    {:ok, _type, nie} = SpanishDoc.parse("Y7136855S")
    assert to_string(nie) == "Y7136855S"
  end
end
