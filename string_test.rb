#!/usr/bin/env ruby

	
class String

	def is_integer?
		self.to_i.to_s == self
	end

	def integer? 
		[                          # In descending order of likeliness:
														 /^[-+]?[1-9]([0-9]*)?$/, # decimal
														 /^0[0-7]+$/,             # octal
														 /^0x[0-9A-Fa-f]+$/,      # hexadecimal
														 /^0b[01]+$/              # binary
		].each do |match_pattern|
			return true if self =~ match_pattern
		end
		return false
	end
end

puts "23 is_integer? #{'23'.is_integer?}"
puts "23 integer? #{'23'.integer?}"

puts "023 is_integer? #{'023'.is_integer?}"
puts "023 integer? #{'023'.integer?}"
