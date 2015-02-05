#!/usr/bin/env ruby


class Array 
  alias :f1 :first
  alias f2 first
  alias_method :f3,:first
  alias_method "f4","first"
end
p [1,2,3].f1
p [1,2,3].f2
p [1,2,3].f3
p [1,2,3].f4


class A
  def method_1
    p "this is method 1 in A"
  end
  def A.rename
    alias :method_2 :method_1
  end
end
class B < A
  def method_1
    p "This is method 1 in B"
  end
  rename
end

B.new.method_2

class A
  def method_1
    p "This is method 1 in   A"
  end
  def A.rename
    alias_method :method_2,:method_1
  end
end
class B < A
  def method_1
    p "This is method 1 in   B"
  end
  rename
end

B.new.method_2

#输出是
#"This is method 1 in A"
#"This is method 1 in B"
#从结果可以看到，如果是alias_method，调用的是子类的方法，如果用的是alias，调用的是父类的方法。
