#!/usr/bin/env ruby








#Eigenclass,也就是我们常说的元类(Metaclass) 
#ClassMethod就是可以MyClass.method的类方法
#InstanceMethod就是可以MyClass.new.method的实例方法




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

