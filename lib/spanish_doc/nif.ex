defmodule SpanishDoc.NIF do
  @moduledoc false

  defstruct [:letter, :number, :checking]

  @letters ~w(K L M)
  defguard is_letter(letter) when letter in @letters

  @checking ~w(T R W A G M Y F P D X B N J Z S Q V H L C K E)
  defguard is_check(checking) when checking in @checking

  defguard is_7digits(number) when number in 0..9_999_999

  defguardp is_8digits(number) when number in 0..99_999_999

  def new(number) when is_8digits(number) do
    checking = Enum.at(@checking, rem(number, 23))
    struct(SpanishDoc.NIF, number: number, checking: checking)
  end

  def new(<<letter::binary-1>>, number) do
    doc = new(number)
    struct(doc, letter: letter)
  end

  defimpl String.Chars do
    def to_string(%SpanishDoc.NIF{} = doc) do
      number = Integer.to_string(doc.number)

      if is_nil(doc.letter) do
        String.pad_leading(number, 8, "0") <> doc.checking
      else
        doc.letter <> String.pad_leading(number, 7, "0") <> Kernel.to_string(doc.checking)
      end
    end
  end
end
