#!/usr/bin/env ruby

# 因为
# class Foo, 
# class<<Foo, 
# class Foo;def self.bar;end;end, 
# 以及class Foo;def Foo.bar;end;end
# 这几种方式都打开了新的scope(作用域).直接的结果是,对外部环境的scope调用不着.

puts self

def m 
  puts self
end

m

puts '############################################################'
module M
  N = 1
end

class A
  include M
  def self.aa
    puts self          #puts A
    puts N             #puts 1
  end

  # By doing class << Person, 
  # we are setting self to Person's metaclass 
  # for the duration of the block. 
  # As a result, the species method is added to Person's metaclass, 
  # rather than the class itself.
  class << self
    def bb
      puts @    #puts A
      aa
      # puts N
    end
  end
end
puts '############################################################'
# A.aa
A.bb

puts A.singleton_methods # => ["aa", "bb"]

puts '############################################################'

foobar = []

class << foobar
  def foo
    "Hello World!"
  end
end

puts foobar.singleton_methods # => ["foo"]
