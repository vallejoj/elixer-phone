defmodule Phone do
  def number(input) do
  input
  |>string_length
  |>letter_test
  
  |>seperate_symbols
  |>test_for_one
  |>join
  |>string_length_three
end

def pretty(input) do
  input
  |>string_length_two
  |>symbol_test
  |>seperate_symbols
  |>test_for_one
  |>join
  |>prettify
end

def area_code(input) do
  input
  |>string_length_two
  |>seperate_symbols
  |>test_for_one
  |>test_for_valid_code
  |>grab_area_code
end

  def grab_area_code(digits) do
    if digits == "000",
    do: digits,
  else: String.slice(digits,0,3)
  end

  def prettify(digits) do
    if digits ==  "00000000000",
    do: "(000) 000-0000",
  else: num_chunk = String.slice(digits,0,3)
        num__chunk_two = String.slice(digits,3,3)
        num__chunk_three = String.slice(digits,6,4)
        "(" <> num_chunk <> ")" <> " " <> num__chunk_two <> "-" <> num__chunk_three
  end

  def join(%Numbers.Digits{newNum: newNum}) do
    if newNum == "000",
    do:   newNum,
  else: Enum.join(newNum)
  end

  def test_for_one(digits) do
    %Numbers.Digits{num: [x|_tail]} = digits
    if x == ["1"] ,
     do: %Numbers.Digits{digits | newNum: [_tail]} ,
   else: %Numbers.Digits{digits | newNum: [x|_tail]}
  end

  def seperate_symbols(input) do
  num = Regex.scan ~r{[0-9]}, input
  %Numbers.Digits{num: num}
  end

  def string_length(input) do
    if String.length(input) > 10,
      do: input,
    else: "0000000000"
  end

  def string_length_two(input) do
    if String.length(input) >= 10,
      do: input,
    else: "0000000000"
  end

   def string_length_three(input) do
    if String.length(input) == 10,
      do: input,
    else: "0000000000"
  end

  def test_for_valid_code( %Numbers.Digits{newNum: [x|tail]}) do
       if hd(x) == ["0"],
       do: "000" ,
       else: Enum.join([x|tail])
  end

  def letter_test(input) do
    if input =~ ~r/[a-z]/i,
    do: "0000000000",
    else: input
  end

  

end
