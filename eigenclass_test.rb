#!/usr/bin/env ruby








#Eigenclass,也就是我们常说的元类(Metaclass) 
#ClassMethod就是可以MyClass.method的类方法
#InstanceMethod就是可以MyClass.new.method的实例方法


class A  
  # defs here go to A  
  puts self  # => A  
  class << self  
    #defs here go to A's eigenclass  
    #这里定义的方法都为元类方法，即A的static方法
		def A_class_self
			puts 'A_class_self'
		end
  end  
end
A.A_class_self
  
A.class_eval do  
  #这里定义的方法都为类方法，即A的实例可以调用的方法
  def A_class_eval
    puts 'A_class_eval'
  end
end

A.new.A_class_eval
  
A.instance_eval do  
  #defs here go to A's eigenclass       
  #这里定义的方法都为元类方法，即A的static方法
  def instance_eval_ss
    puts 'instance_eval_ss'
  end
end
A.instance_eval_ss
  
s = "Hello World"  
  
class << s  
  def class_s_ss
    puts 'class << s  -> ss'
  end
  #defs here go to s's eigenclass  
end

class Kitty
  def hi
    puts 'hi kitty'
  end

  class << self
    Object::A = self #获取Kitty的eigenclass类
    def foo
    end
  end
end

class Object::A #打开Kitty的eigenclass类
  def hello
    puts 'hello kitty'
  end
end

k = Kitty.new
k.hi                 # => "hi kitty"
Kitty.hello #调用实例方法  => "hello kitty"
puts Object::A.instance_methods.include? :hello

# Kitty 's singleton_class is Object::A
#
p "Object::A.instance_methods size is #{Object::A.instance_methods.size}"
p "Kitty.singleton_methods are #{Kitty.singleton_methods}"
p "Kitty.singleton_class's singleton_methods are #{Kitty.singleton_class.singleton_methods}"
p "Object::A.singleton_methods are #{Object::A.singleton_methods}"
# Object::A.new  #报can't create instance of virtual class (TypeError) 错误
#

message = "hello"
class << message
  def world
    puts 'hello world'
  end
end
message.world

