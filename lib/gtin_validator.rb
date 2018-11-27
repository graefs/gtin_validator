require "gtin_validator/version"

module GtinValidator
  class << self
    def valid_gtin?(number)
      number = number.digits # Create an array of digits (reverse is not needed since Enumerable#digits extracts from right to left)
      return false unless [8,12,13,14].include? number.size
      
      chr, *ary = number
      evens, odds = ary.partition.with_index(1) { |_, i| i.even? } # Split array in two based on index even / odd
      chr == ((10 - ((odds.sum * 3) + evens.sum)) % 10)
    end

    def calculate_checkdigit(number)
      number = number.digits
      return false unless [7,11,12,13].include? number.size
      
      chr, *ary = number
      evens, odds = ary.partition.with_index { |_, i| i.even? } # Split array in two based on index even / odd
      ((10 - ((odds.sum * 3) + evens.sum)) % 10)
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
