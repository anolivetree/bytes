# bytes

[![Package Version](https://img.shields.io/hexpm/v/bytes)](https://hex.pm/packages/bytes)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/bytes/)

```sh
gleam add bytes
```
```gleam
import bytes

pub fn main() -> Nil {
  echo bytes.find(<<"hello">>, <<"ll">>) // Ok(2)
  echo bytes.trim(<<"  \tabcde\r\n ">>) == <<"abcde">> // True
  echo bytes.split(<<"1\n23\n456">>, <<"\n">>) == [<<"1\n">>, <<"23\n">>, <<"456">>] // True
  Nil
}
```

Further documentation can be found at <https://hexdocs.pm/bytes>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
