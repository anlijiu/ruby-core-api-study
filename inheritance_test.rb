#!/usr/bin/env ruby


p "Start ============================================================================"
class Animal
  def initialize(name)
    @name = name
  end

  def info
    puts "I'm a #{self.class}."
    puts "My name is '#{@name}'."
  end
end

class Dog < Animal
  def info
    puts "I #{make_noise}."
    super
  end

  def make_noise
    'bark "Woof woof"'
  end
end

lassie = Dog.new "Lassie"
lassie.info

p "1 类继承================================================================================="

p "Dog.superclass is #{Dog.superclass}"
p "Dog.ancestors are #{Dog.ancestors}"
p "Dog.ancestors include? Animal #{Dog.ancestors.include? :Animal}"
p "lassie.respond_to? :upcase #{lassie.respond_to? :upcase}" # => false
p "lassie.respond_to? :make_noise #{lassie.respond_to? :make_noise}" # => true
p "lassie.methods are #{lassie.methods}"
# => I bark "Woof woof".
# #    I'm a dog.
# #    My name is 'Lassie'
#

p "2 module mixin ================================================================================="

module Mammal
  def info
    puts "I'm a mammal"
    super
  end
end
Mammal.class # => Module

class Dog
  #include Mammal      #如果用include 做mixin  则先调用  Dog 的 info ,然后调用Mammal的info
  prepend Mammal     #如果用prepend 做mixin  则先调用  Mammal的 info ,然后调用 Dog的info
                      # 下面打印的 Dog.ancestors  解释了调用顺序
end
lassie = Dog.new "Lassie"
lassie.info
p "Dog.ancestors are #{Dog.ancestors}"

p "3 对象的单件类singleton_class================================================================================="
scooby = Dog.new "Scooby-Doo"
class << scooby
  def make_noise
    'howl "Scooby-Dooby-Doo!"'
  end
end
# class << scooby 等同与
# def scooby.make_noise
#   'howl "wo cao -Dooby-Doo!"'
# end
scooby.info
# => I'm a mammal.
#    I howl "Scooby-Dooby-Doo!".
#    I'm a dog.
#    My name is 'Scooby-Doo'.

#Singleton classes have strange names:
p "scooby.singleton_class is #{scooby.singleton_class}"   # => #<Class:#<Dog:0x00000100a0a8d8>>
# # Singleton classes are real classes:
p "scooby.singleton_class.is_a?(Class) => #{scooby.singleton_class.is_a?(Class)}" # => true
# # We can get a list of its instance methods:
p "scooby.singleton_class.instance_methods(false) is #{scooby.singleton_class.instance_methods(false)}" # => [:make_noise]

p "is :attr_accessor Module.singleton_class's method => 
    #{Module.singleton_class
      .private_instance_methods
      .include?(:attr_accessor)}" # => true

require 'active_record'
p "ActiveRecord::Base.singleton_method's instance_methods size is 
                #{ActiveRecord::Base.singleton_class
                  .instance_methods(false)
                  .size}"  # => 一百多个

  #scooby2 = scooby.singleton_class.new
  #错误!!! 无法创建singleton class 的对象实例 => TypeError: can't create instance of singleton class
  
  #class Scoobies < scooby.singleton_class
  # ...
  #end
  #错误!!! 同样无法继承singleton_class      => TypeError: can't make subclass of singleton class

#=> true, as for most objects 
#scooby.singleton_class.superclass == scooby.class == Dog    true !!!
p "scooby.singleton_class.superclass == scooby.class ? #{scooby.singleton_class.superclass == scooby.class}"
p "Dog  == scooby.class ? #{Dog == scooby.class}"

p "Dog.singleton_class.superclass == Dog.superclass.singleton_class  => #{Dog.singleton_class.superclass == Dog.superclass.singleton_class}"
# => true, as for any Class
# 意味着Dog 从Animal继承了 instance methods 和singleton methods

p "4 extend 和 include/prepend ========================================================================"

module Mixin
  def info
    puts "I'm a Mixin"
  end
end
class A
end

A.extend(Mixin)
A.info
#extend 成为类方法， 所以需要 A.info 调用 ，  而 include/prepend 成为实例方法， 所以要 A.new.info 这样的方式调用
p "extend 成为类方法， 所以需要 A.info 调用 ，  而 include/prepend 成为实例方法， 所以要 A.new.info 这样的方式调用"
#       所以  obj.extend MyModule
# is a shortcut for
#             class << obj
#               include MyModule
#             end


p "Method lookup and method missing ===================================================================="

#lassie.woof # => NoMethodError: undefined method
  # `woof' for #<Dog:0x00000100a197e8 @name="Lassie">

class Animal
  def method_missing(method, *args)
    if make_noise.include? method.to_s
      puts make_noise
    else
      super
    end
  end
end

lassie.woof # => bark "Woof woof!"
#scooby.woof # => NoMethodError ...
scooby.howl # => howl "Scooby-Dooby-Doo!"

s = 'bark "Woof woof"'
ss = "woof"
p "bark Woof woof .include ? woof => #{s.include?ss}"
