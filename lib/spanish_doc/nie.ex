defmodule SpanishDoc.NIE do
  @moduledoc false

  defstruct [:letter, :number, :checking]

  @letters ~w(X Y Z)
  defguard is_letter(letter) when letter in @letters

  @checking ~w(T R W A G M Y F P D X B N J Z S Q V H L C K E)
  defguard is_check(checking) when checking in @checking

  def new(<<letter::binary-1>>, number) do
    checking =
      @letters
      |> Enum.with_index()
      |> Enum.find_value(fn {char, index} ->
        if char == letter, do: index * 10_000_000 + number
      end)
      |> rem(23)
      |> then(fn digit -> Enum.at(@checking, digit) end)

    struct(SpanishDoc.NIE, type: :nie, letter: letter, number: number, checking: checking)
  end

  defimpl String.Chars do
    def to_string(%SpanishDoc.NIE{} = doc) do
      number = Integer.to_string(doc.number)
      doc.letter <> String.pad_leading(number, 7, "0") <> Kernel.to_string(doc.checking)
    end
  end
end
