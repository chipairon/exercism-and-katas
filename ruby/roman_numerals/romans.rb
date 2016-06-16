#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class Romans

  IS_ROMAN = / ^ M{0,3}
                 (?:CM|DC{0,3}|CD|C{0,3})
                 (?:XC|LX{0,3}|XL|X{0,3})
                 (?:IX|VI{0,3}|IV|I{0,3}) $ /ix
  IS_ARABIC = /^(?:[123]\d{3}|[1-9]\d{0,2})$/

  def initialize
    construct_roman_table
  end

  def construct_roman_table
    roman_map = {
      1    => "I",
      4    => "IV",
      5    => "V",
      9    => "IX",
      10   => "X",
      40   => "XL",
      50   => "L",
      90   => "XC",
      100  => "C",
      400  => "CD",
      500  => "D",
      900  => "CM",
      1000 => "M"
    }

    @@roman_table = Array.new(3999) do |index|
      target = index + 1
      roman_map.keys.sort { |a, b| b <=> a }.inject("") do |roman, div|
        times, target = target.divmod(div)
        roman << roman_map[div] * times
      end
    end
  end

  def to_roman str
    @@roman_table.index(str) + 1
  end

  def to_arabic str
    @@roman_table[str.to_i - 1]
  end

  def convert str
    case str
    when IS_ROMAN  then puts to_roman(str)
    when IS_ARABIC then puts to_arabic(str)
    else raise "Invalid input:  #{str}"
    end
  end
end

if __FILE__ == $0
  romans = Romans.new
  ARGF.each_line() do |line|
    line.chomp!
    romans.convert line
  end
end
