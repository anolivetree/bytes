

import gleam/bit_array
import gleam/result
import gleam/list


pub fn find(d: BitArray, pattern: BitArray) -> Result(Int, Nil) {
  find_recursive(d, pattern, 0)
}

fn find_recursive(d: BitArray, pattern: BitArray, pos: Int) -> Result(Int, Nil) {
  let pattern_length = bit_array.byte_size(pattern)
  use slice <- result.try(bit_array.slice(d, pos, pattern_length))
  case slice == pattern {
    True -> Ok(pos)
    False -> find_recursive(d, pattern, pos+1)
  }
}

pub fn split_once(d: BitArray, separator: BitArray) -> List(BitArray) {
  case find(d, separator) {
    Ok(pos) -> {
      let sep_len = bit_array.byte_size(separator)
      let assert Ok(d1) = bit_array.slice(d, 0, pos + sep_len)
      let assert Ok(d2) = bit_array.slice(d, pos + sep_len, bit_array.byte_size(d) - pos - sep_len)
      case d2 {
        <<>> -> [d1]
        _ -> [d1, d2]
      }

    }
    Error(_) -> [d]
  }
}

pub fn split(d: BitArray, separator: BitArray) -> List(BitArray) {
  split_recursive(d, separator, [])
  |> list.reverse
}

fn split_recursive(d: BitArray, separator: BitArray, acc: List(BitArray)) -> List(BitArray) {
  case split_once(d, separator) {
    [d1, d2] -> split_recursive(d2, separator, [d1, ..acc])
    _ -> [d, ..acc]
  }
}


pub fn trim_start(d: BitArray) -> BitArray {
  case d {
    <<" ", rest:bits>>
    | <<"\t", rest:bits>>
    | <<"\n", rest:bits>>
    | <<"\r", rest:bits>> -> trim_start(rest)
    _ -> d
  }
}

pub fn trim_end(d: BitArray) -> BitArray {
  let len = bit_array.byte_size(d)
  case bit_array.slice(d, len - 1, 1) {
    Ok(<<" ">>)
    | Ok(<<"\t">>)
    | Ok(<<"\n">>)
    | Ok(<<"\r">>) -> trim_end(bit_array.slice(d, 0, len - 1) |> result.unwrap(<<>>))
    _ -> d
  }
}

pub fn trim(d: BitArray) -> BitArray {
  d |> trim_start |> trim_end
}

