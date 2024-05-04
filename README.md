# Introduction

**SpanishDoc** is a library to parse Spanish identity documentation numbers like:

  * NIF: _Número de Identificación Fiscal._
  * NIE: _Número de Identificación de Extranjeros._

## Installation

Add `spanish_doc` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:spanish_doc, "~> 1.4.0"}
  ]
end
```

## Usage

```elixir
SpanishDoc.valid?("16659622D")
true

SpanishDoc.parse("16.659.622-D")
{:ok, :nif, "16659622D"}

SpanishDoc.obfuscate("E90725946")
{:ok, :nif, "***7259**"}
```
