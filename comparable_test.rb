#!/usr/bin/env ruby

#size 比较
class SizeMatters
  include Comparable
  attr :str
  def <=>(anOther)
    str.size <=> anOther.str.size
  end
  def initialize(str)
    @str = str
  end
  def inspect
    @str
  end
end

s1 = SizeMatters.new("Z")
s2 = SizeMatters.new("YY")
s3 = SizeMatters.new("XXX")
s4 = SizeMatters.new("WWWW")
s5 = SizeMatters.new("VVVVV")

p "Z < YY ? => #{'Z' < 'YY'}"
p "SizeMatters : Z < YY ? => #{s1 < s2}"                                     #=> true
p "SizeMatters : WWWW between Z , XXX ? => #{s4.between?(s1, s3)}"           #=> false
p "SizeMatters : WWWW between XXX, VVVVV ? => #{s4.between?(s3, s5)}"        #=> true
p [ s3, s2, s5, s4, s1 ].sort   #=> [Z, YY, XXX, WWWW, VVVVV]  #从小到大排序

p 3.between?(1, 5)               #=> true
p 6.between?(1, 5)               #=> false
p 'cat'.between?('ant', 'dog')   #=> true
p 'gnu'.between?('ant', 'dog')   #=> false



















