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
  |>seperate_numbers_and_check
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

  #grabs first 3 numbers in a string
  def grab_area_code(digits) do
   if digits == "000",
     do: digits,
     else: String.slice(digits,0,3)
  end

  #tests to see if first number in list is a 0
  def test_for_valid_code( %Numbers.Digits{newNum: [x|tail]}) do
   if hd(x) == ["0"],
     do: "000" ,
     else: Enum.join([x|tail])
  end

  #breaks apart string into chunks and then inserts special characters to 'prettify' string
  def prettify(digits) do
   if digits ==  "00000000000",
     do: "(000) 000-0000",
     else: num_chunk = String.slice(digits,0,3)
        num__chunk_two = String.slice(digits,3,3)
        num__chunk_three = String.slice(digits,6,4)
        "(" <> num_chunk <> ")" <> " " <> num__chunk_two <> "-" <> num__chunk_three
  end

  #joins strings from list of list
  def join(%Numbers.Digits{newNum: newNum}) do
   if newNum == "000",
     do: newNum,
     else: Enum.join(newNum)
  end

  #testing to see if first number in string is 1
  def test_for_one(digits) do
    %Numbers.Digits{num: [x|_tail]} = digits
   if x == ["1"] ,
     do: %Numbers.Digits{digits | newNum: [_tail]} ,
     else: %Numbers.Digits{digits | newNum: [x|_tail]}
  end

  #takes out symbols and leaves only numbers
  def seperate_symbols(input) do
    num = Regex.scan ~r{[0-9]}, input
    %Numbers.Digits{num: num}
  end

  #takes out "-" and checks to see if there are two, need to refactor this to be more dynamic
  def seperate_numbers_and_check(input) do
    sym = Regex.scan ~r{[-]}, input
   if sym == [["-"], ["-"]],
     do: "0000000000",
     else: input
  end

  #checking to see if any letters are in the string
  def letter_test(input) do
    if input =~ ~r/[a-z]/i,
     do: "0000000000",
     else: input
  end
  #tests to make sure string length is not to long
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

  #final string length check for phone
   def string_length_three(input) do
    if String.length(input) == 10,
      do: input,
      else: "0000000000"
  end

 

end
