defmodule SpanishDoc do
  @moduledoc """
  A module to process Spanish NIF/NIE document numbers.
  """

  alias SpanishDoc.NIF
  alias SpanishDoc.NIE

  require NIF
  require NIF.Legal
  require NIE

  @doc """
  Checks the NIF/NIE document number has a valid NIF/NIE format.

  ## Examples

      iex> SpanishDoc.valid?("16659622D")
      true

      iex> SpanishDoc.valid?("16659622X")
      false

      iex> SpanishDoc.valid?("error")
      false

  """
  @spec valid?(String.t()) :: boolean()
  def valid?(text) when is_binary(text) do
    case new(text) do
      {:ok, _doc} -> true
      {:error, _reason} -> false
    end
  end

  @doc """
  Parses a text representation of a NIF/NIE document number.

  ## Examples

      iex> SpanishDoc.parse("16659622D")
      {:ok, :nif, "16659622D"}

      iex> SpanishDoc.parse("M2919200V")
      {:ok, :nif, "M2919200V"}

      iex> SpanishDoc.parse("Q4978527B")
      {:ok, :nif, "Q4978527B"}

      iex> SpanishDoc.parse("Y6115461M")
      {:ok, :nie, "Y6115461M"}

      iex> SpanishDoc.parse("16.659.622-D")
      {:ok, :nif, "16659622D"}

      iex> SpanishDoc.parse("16659622Z")
      {:error, "Document not valid"}

      iex> SpanishDoc.parse("12345678")
      {:error, "Document not valid"}

      iex> SpanishDoc.parse("hello")
      {:error, "Document not valid"}

  """
  @spec parse(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def parse(text) when is_binary(text) do
    with {:ok, doc} <- new(text), do: {:ok, doc_type(doc), to_string(doc)}
  end

  @doc """
  Obfuscate a NIF/NIE document number.

  ## Examples

      iex> SpanishDoc.obfuscate("85033335N")
      {:ok, :nif, "***3333**"}

      iex> SpanishDoc.obfuscate("E90725946")
      {:ok, :nif, "***7259**"}

      iex> SpanishDoc.obfuscate("Y7811422S")
      {:ok, :nie, "****1422*"}

      iex> SpanishDoc.obfuscate("hello")
      {:error, "Document not valid"}

  """
  @spec obfuscate(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def obfuscate(text) when is_binary(text) do
    with {:ok, doc} <- new(text) do
      case doc do
        %NIF{} ->
          {:ok, doc_type(doc), "***" <> String.slice(text, 3, 4) <> "**"}

        %NIE{} ->
          {:ok, doc_type(doc), "****" <> String.slice(text, 4, 4) <> "*"}
      end
    end
  end

  defp new(<<letter::binary-1, number::binary-7, checking::binary-1>>)
       when NIF.is_letter(letter) and NIF.is_check(checking) do
    with {number, ""} when NIF.is_7digits(number) <- Integer.parse(number),
         %NIF{} = nif when nif.checking == checking <- NIF.new(letter, number) do
      {:ok, nif}
    else
      _ -> parse_error()
    end
  end

  defp new(<<letter::binary-1, number::binary-7, checking::binary-1>>)
       when NIF.Legal.is_letter(letter) and NIF.Legal.is_check(checking) do
    with {number, ""} when NIF.is_7digits(number) <- Integer.parse(number),
         %NIF{} = nif <- NIF.Legal.new(letter, number) do
      if checking == to_string(nif.checking) do
        {:ok, nif}
      else
        parse_error()
      end
    else
      _ -> parse_error()
    end
  end

  defp new(<<letter::binary-1, number::binary-7, checking::binary-1>>)
       when NIE.is_letter(letter) and NIE.is_check(checking) do
    with {number, ""} <- Integer.parse(number),
         %NIE{} = nie when nie.checking == checking <- NIE.new(letter, number) do
      {:ok, nie}
    else
      _ -> parse_error()
    end
  end

  defp new(<<number::binary-8, checking::binary-1>>) when NIF.is_check(checking) do
    with {number, ""} <- Integer.parse(number),
         %NIF{} = nif when nif.checking == checking <- NIF.new(number) do
      {:ok, nif}
    else
      _ -> parse_error()
    end
  end

  defp new(text) when byte_size(text) == 9, do: parse_error()

  defp new(text) when is_binary(text) do
    case text |> String.replace([" ", ".", "-"], "") |> String.upcase() do
      text when byte_size(text) == 9 -> new(text)
      _ -> parse_error()
    end
  end

  defp parse_error(), do: {:error, "Document not valid"}

  defp doc_type(%NIF{}), do: :nif
  defp doc_type(%NIE{}), do: :nie
end
