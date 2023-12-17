# SpanishDoc

A library to parse Spanish identity documentation numbers like:

  * NIF: Número de Identificación Fiscal
  * NIE: Número de Identificación de Extranjeros

## Installation

Add `spanish_doc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:spanish_doc, "~> 1.0.0"}
  ]
end
```

## Usage

```elixir
SpanishDoc.valid?("16659622D")
true

SpanishDoc.parse("16.659.622-D")
{:ok, "16659622D"}

SpanishDoc.obfuscate("E90725946")
{:ok, "***7259**"}
```
