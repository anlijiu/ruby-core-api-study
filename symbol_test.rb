
####  %i(address city state postal country)   等于 %w[address city state postal country].map(&:to_sym) 
####  都是生成一个symbol 数组   => [:address, :city, :state, :postal, :country]
