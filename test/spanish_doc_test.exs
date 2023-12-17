defmodule SpanishDocTest do
  use ExUnit.Case
  doctest SpanishDoc

  test "the String.Chars protocol" do
    {:ok, nif} = SpanishDoc.parse("16659622D")
    assert to_string(nif) == "16659622D"

    {:ok, nie} = SpanishDoc.parse("Y7136855S")
    assert to_string(nie) == "Y7136855S"
  end
end
