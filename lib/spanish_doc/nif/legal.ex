defmodule SpanishDoc.NIF.Legal do
  @moduledoc false

  require Integer

  @digits ~w(A B C D E F G H J U V)
  @alphas ~w(P Q R S N W)
  defguard is_letter(checking) when checking in @digits or checking in @alphas

  @checking ~w(T R W A G M Y F P D X B N J Z S Q V H L C K E 0 1 2 3 4 5 6 7 8 9)
  defguard is_check(checking) when checking in @checking

  def new(<<letter::binary-size(1)>>, number) do
    {even, odd} =
      number
      |> Integer.to_string()
      |> String.pad_leading(7, "0")
      |> String.graphemes()
      |> Enum.with_index(fn digit, index -> {String.to_integer(digit), index} end)
      |> Enum.split_with(fn {_digit, index} -> Integer.is_odd(index) end)

    even = Enum.reduce(even, 0, fn {digit, _index}, acc -> digit + acc end)

    odd =
      Enum.reduce(odd, 0, fn {digit, _index}, acc ->
        case Integer.digits(digit * 2) do
          [units] -> units + acc
          [tens, units] -> tens + units + acc
        end
      end)

    digit =
      (10 - rem(even + odd, 10))
      |> Integer.digits()
      |> List.last()

    checking =
      cond do
        letter in @alphas ->
          <<64 + digit>>

        letter in @digits and digit == 10 ->
          0

        letter in @digits ->
          digit
      end

    struct(SpanishDoc.NIF, letter: letter, number: number, checking: checking)
  end
end
