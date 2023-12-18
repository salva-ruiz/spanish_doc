# Changelog for SpanishDoc

## v1.1.0 (2023-12-18)

* The functions `SpanishDoc.parse/1` and `SpanishDoc.obfuscate/1` now return a
tuple with the document type:

```elixir
SpanishDoc.parse("Y6115461M")
{:ok, :nie, "Y6115461M"}

SpanishDoc.obfuscate("85033335N")
{:ok, :nif, "***3333**"}
```

* Added this `CHANGELOG.md` file to keep track of the changes.

## v1.0.0 (2023-12-17)

* This is the first production ready release.