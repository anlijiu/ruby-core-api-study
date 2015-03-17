#!/usr/bin/env ruby
require 'pp'


ary = [1, "two", 3.0] #=> [1, "two", 3.0]
pp ary

ary = Array.new    #=> []
pp ary
pp Array.new(3)       #=> [nil, nil, nil]
pp Array.new(3, true) #=> [true, true, true]
pp Array.new(4) { Hash.new } #=> [{}, {}, {}, {}]
empty_table = Array.new(3) { Array.new(3) }
pp empty_table
pp Array({:a => "a", :b => "b"}) #=> [[:a, "a"], [:b, "b"]]

arr = [1, 2, 3, 4, 5, 6]
arr[2]    #=> 3
arr[100]  #=> nil
arr[-3]   #=> 4
arr[2, 3] #=> [3, 4, 5]
pp arr[1..4] #=> [2, 3, 4, 5]
pp arr[1..-3] #=> [2, 3, 4]

arr = ['a', 'b', 'c', 'd', 'e', 'f']
#pp arr.fetch(100) #=> IndexError: index 100 outside of array bounds: -6...6
pp arr.fetch(100, "oops") #=> "oops"

pp arr.first #=> 1
pp arr.last  #=> 6

pp arr.take(3) #=> [1, 2, 3]
pp arr.drop(3) #=> [4, 5, 6]
pp arr         #=> [1, 2, 3, 4, 5, 6]
arr.insert(3, 'orange', 'pear', 'grapefruit')
pp arr
#arr.push  <<  为追加  unshift 为头插入
pp arr.pop #=> 6
pp arr
pp arr.shift  #头弹出
pp arr
pp arr.delete_at(2)  # 删除 arr[2]
pp arr
arr << "pear"
pp arr
pp arr.delete("pear")  #删除所有pear
pp arr




arr = ['foo', 0, nil, 'bar', 7, 'baz', nil]
arr.compact  #=> ['foo', 0, 'bar', 7, 'baz']    remove all nil
p arr          #=> ['foo', 0, nil, 'bar', 7, 'baz', nil]
arr.compact! #=> ['foo', 0, 'bar', 7, 'baz']
p arr          #=> ['foo', 0, 'bar', 7, 'baz']

arr = [2, 5, 6, 556, 6, 6, 8, 9, 0, 123, 556]
arr.uniq #=> [2, 5, 6, 556, 8, 9, 0, 123]      不计重复

arr = [1, 2, 3, 4, 5]
arr.each { |a| print a -= 10, " " }  


words = %w[first second third fourth fifth sixth]
str = ""
words.reverse_each { |word| str += "#{word} " }
p str #=> "sixth fifth fourth third second first "

pp arr.map { |a| 2*a }   #=> [2, 4, 6, 8, 10]
pp arr                   #=> [1, 2, 3, 4, 5]
pp arr.map! { |a| a**2 } #=> [1, 4, 9, 16, 25]    **为平方
pp arr                   #=> [1, 4, 9, 16, 25]

arr = [1, 2, 3, 4, 5, 6]
pp arr.select { |a| a > 3 }     #=> [4, 5, 6]
pp arr.reject { |a| a < 3 }     #=> [3, 4, 5, 6]
pp arr.drop_while { |a| a < 4 } #=> [4, 5, 6]
pp arr                          #=> [1, 2, 3, 4, 5, 6]

pp arr.delete_if { |a| a < 4 } #=> [4, 5, 6]
pp arr                         #=> [4, 5, 6]

arr = [1, 2, 3, 4, 5, 6]
p arr.keep_if { |a| a < 4 } #=> [1, 2, 3]
p arr                       #=> [1, 2, 3]

a = Array.[]( 1, 'a', /^A/ ) # => [1, "a", /^A/]
p a
a = Array[ 1, 'a', /^A/ ]    # => [1, "a", /^A/]
p a
a = [ 1, 'a', /^A/ ]         # => [1, "a", /^A/]
p a

p first_array = ["Matz", "Guido"]

p second_array = Array.new(first_array) #=> ["Matz", "Guido"]

p first_array.equal? second_array       #=> false

p Array.new(3){ |index| index ** 2 }    # => [0, 1, 4]
pp a = Array.new(2, Hash.new)           # => [{}, {}]

a[0]['cat'] = 'feline'
p a # => [{"cat"=>"feline"}, {"cat"=>"feline"}]
a[1]['cat'] = 'Felix'
a # => [{"cat"=>"Felix"}, {"cat"=>"Felix"}]
# 因为array a 里面的hash 均为同一个， 所以改一个全变
a = Array.new(2) { Hash.new }   #这样声明就OK了， array中每一个元素都 Hash.new ，所以为不同元素了
a[0]['cat'] = 'feline'
pp a # => [{"cat"=>"feline"}, {}]


Array.try_convert([1])   #=> [1]
Array.try_convert("1")   #=> nil

arg = [123]
if tmp = Array.try_convert(arg)
  p "#{arg} is an array"
    # the argument is an array
elsif tmp = String.try_convert(arg)
  #   # the argument is a string
  p "#{arg} is an string"
end



pp "[ 1, 1, 3, 5 ] & [ 1, 2, 3 ] => #{[ 1, 1, 3, 5 ] & [ 1, 2, 3 ]}"                 #=> [ 1, 3 ]
pp [ 'a', 'b', 'b', 'z' ] & [ 'a', 'b', 'c' ]   #=> [ 'a', 'b' ]

p [ 1, 2, 3 ] * 3    #=> [ 1, 2, 3, 1, 2, 3, 1, 2, 3 ]
p [ 1, 2, 3 ] * ","  #=> "1,2,3"






























