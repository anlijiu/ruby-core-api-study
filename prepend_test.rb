module A
  def self.prepended(mod)
    puts "#{self} prepended to #{mod}"
  end
end

module Enumerable
  prepend A
end
# => prints "A prepended to Enumerable"
