import gleam/bit_array
import bytes
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn find_test() {

  let a = bit_array.from_string("hello")

  assert bytes.find(a, bit_array.from_string("he")) == Ok(0)
  assert bytes.find(a, bit_array.from_string("hello")) == Ok(0)
  assert bytes.find(a, bit_array.from_string("el")) == Ok(1)
  assert bytes.find(a, bit_array.from_string("llo")) == Ok(2)
  assert bytes.find(a, bit_array.from_string("o")) == Ok(4)
  assert bytes.find(a, bit_array.from_string("z")) == Error(Nil)
}

pub fn split_once_test() {
  let a = bit_array.from_string("hello\r\nworld")
  assert bytes.split_once(a, <<"\r\n">>) == [<<"hello\r\n">>,<<"world">>]
  assert bytes.split_once(a, <<"\n">>) == [<<"hello\r\n">>,<<"world">>]

  let b = bit_array.from_string("\nhelloworld")
  assert bytes.split_once(b, <<"\n">>) == [<<"\n">>,<<"helloworld">>]
  assert bytes.split_once(b, <<"z">>) == [<<"\nhelloworld">>]
  assert bytes.split_once(b, <<"\nhelloworld">>) == [<<"\nhelloworld">>]
  assert bytes.split_once(b, <<"l">>) == [<<"\nhel">>, <<"loworld">>]
}

pub fn split_test() {
  let a = bit_array.from_string("hello\r\nworld")
  assert bytes.split(a, <<"\r\n">>) == [<<"hello\r\n">>,<<"world">>]
  assert bytes.split(a, <<"\n">>) == [<<"hello\r\n">>,<<"world">>]

  let b = bit_array.from_string("\nhelloworld")
  assert bytes.split(b, <<"\n">>) == [<<"\n">>,<<"helloworld">>]
  assert bytes.split(b, <<"z">>) == [<<"\nhelloworld">>]
  assert bytes.split(b, <<"\nhelloworld">>) == [<<"\nhelloworld">>]
  assert bytes.split(b, <<"l">>) == [<<"\nhel">>, <<"l">>, <<"oworl">>, <<"d">>]

  let c = bit_array.from_string("\nhello\nworld\n")
  assert bytes.split(c, <<"\n">>) == [<<"\n">>,<<"hello\n">>,<<"world\n">>]
}

pub fn trim_start_test() {
  let a = bit_array.from_string("hello\r\n")
  assert bytes.trim_start(a) == <<"hello\r\n">>

  let b = bit_array.from_string("\t\r\n h ello\r\t \n")
  assert bytes.trim_start(b) == <<"h ello\r\t \n">>
}

pub fn trim_end_test() {
  let a = bit_array.from_string("\r\nhello")
  assert bytes.trim_end(a) == <<"\r\nhello">>

  let b = bit_array.from_string("\t\r\n h ello\r\t \n")
  assert bytes.trim_end(b) == <<"\t\r\n h ello">>
}


pub fn trim_test() {
  let a = bit_array.from_string("hello")
  assert bytes.trim(a) == <<"hello">>

  let b = bit_array.from_string("\t\r\n h \nello\r\t \n")
  assert bytes.trim(b) == <<"h \nello">>
}
