require "gtin_validator/version"

module GtinValidator
  class << self
    def valid_gtin?(number)
      number = number.to_s.reverse # Transform the number into String to invert.
      return false unless [8,12,13,14].include? number.length
      odds = evens = 0

      # Skip the first number (check digit)
      (1..number.length - 1).each do |n|
        # Add number to evens or odds
        n.even? ? (evens += number[n].chr.to_i) : (odds += number[n].chr.to_i)
      end

      # Check if check digit == result of check digit operation
      number[0].chr.to_i == ((10 - ((odds * 3) + evens)) % 10)
    end

    def calculate_checkdigit(number)
      number = number.to_s.reverse
      return false unless [7,11,12,13].include? number.length
      odds = evens = 0

      (0..number.length - 1).each do |n|
        i = n + 1
        i.even? ? (evens += number[n].chr.to_i) : (odds += number[n].chr.to_i)
      end

      ((10 - ((odds * 3) + evens)) % 10)
    end

    def what_gtin_is?(number)
      case number.to_s.length
      when 8
        gtin_8?(number.to_s) ? "GTIN-8" : false
      when 12
        gtin_12?(number.to_s) ? "GTIN-12" : false
      when 13
        gtin_13?(number.to_s) ? "GTIN-13" : false
      when 14
        gtin_14?(number.to_s) ? "GTIN-14" : false
      else
        false
      end
    end

    def gtin_14?(gtin)
      return false if gtin.to_s.length != 14
      valid_gtin? gtin
    end
    alias is_gtin_14? gtin_14?

    def gtin_13?(gtin)
      return false if gtin.to_s.length != 13
      valid_gtin? gtin
    end
    alias ean? gtin_13?
    alias is_ean? gtin_13?
    alias ean_13? gtin_13?
    alias is_gtin_13? gtin_13?

    def gtin_12?(gtin)
      return false if gtin.to_s.length != 12
      valid_gtin? gtin
    end
    alias upc? gtin_12?
    alias is_upc? gtin_12?
    alias upc_12? gtin_12?
    alias is_gtin_12? gtin_12?

    def gtin_8?(gtin)
      return false if gtin.to_s.length != 8
      valid_gtin? gtin
    end
    alias ean_8? gtin_8?
    alias is_gtin_8? gtin_8?
  end
end
