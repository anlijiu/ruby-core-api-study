#!/usr/bin/env ruby

require 'pp'

=begin
puts 'self => ',self, "\n"

print 'self.class => ', self.class, "\n"

@self1 = self

def a_method
  @self2 = self
  print 'self => ',self, "\n"
  print '@self1 == @self2 ? => ', @self1 == @self2, "\n"
end

a_method
=end

# 这个位置位于top level context，代表Object的默认对象main
puts "\n预期打印 self => main"
puts self, "\n" # => main
p "预期打印 self.class => Object"
puts self.class, "\n" # => Object
@self1 = self

# 因为所有自定义类都位于main context之中，所以这是Object的实例方法
# 同时也可以说是一个全局方法
def a_method
  @self2 = self
  p "预期打印 self => main"
  puts self , "\n"
  # => main，因为有了实例变量@self1和@self2，所以打印出来的不是main这个字符
  # => 但仍然是main对象，注释掉4，8行即可看到效果
  p "预期打印 @self1 == @self2  => true"
  puts @self1 == @self2, "\n" # => true
end

a_method

# 下面是一个关于类中不同上下文的self
class Person
  p "预期打印self => Person，代表当前类"
  puts self, "\n"
  
  
  def instance_method
    p "预期打印instance_method => <Person:0xb7818fdc>，代表当前类的实例"
    puts self, "\n" # => #<Person:0xb7818fdc>，代表当前类的实例
  end
  
  def self.class_method
    p "预期打印 self.class_method => Person，和第16行一样代表当前类（这是类方法的context），它们是相等的"
    puts self, "\n" # => Person，和第16行一样代表当前类（这是类方法的context），它们是相等的
  end
end

m = Person.new
def m.hello
  p "预期打印Person.new.hello  self => <Person:0xb7818fdc>，self 代表单例对象"
  p self # => 代表m这个单例对象
end

m.hello

def mp(a, b)
  puts "\n预期打印 #{a} => #{b}"
end

class Person
  attr_accessor :name

  def set_name(your_name)
    name = your_name  #这里的name 是局部变量，类变量应该用@name
  end
end

m = Person.new
mp 'm.name', 'nil'
p m.name
m.set_name('today')
mp 'after set_name, m.name', 'nil'
p m.name # => 还是nil




class Person
  public
  def get_my_secret1
    my_secret # => 隐式 self
  end

  def get_my_secret2
    self.my_secret # => 显式self 不可调用private方法， 调用便出错private method error
  end

  private
  def my_secret
    p 'something...'
  end

  def self.secret   #self的方法是类方法，而权限修饰符只对实例方法生效, 所以self.secret不受private限制
    p 'nothing'
  end
end

m = Person.new
#m.my_secret # => private method error 
mp 'Person.secret', 'nothing'
Person.secret # => nothing

mp 'm.get_my_secret1', 'something'
m.get_my_secret1 # => something
# m.get_my_secret2 # => private method error


#self 的怪异写法。。。
class Person
  def metaclass
    class << self
      def sss
        puts 'sss in class << self'
      end
      self
    end
  end
  
  def metaclass2
    self
  end
end

a = Person.new
# a.sss #这里打印会出错,因为需要执行metaclass方法之后， Person的实例对象才会有sss方法

b = a.metaclass
c = a.metaclass2
# 首先要明白，类Person是Class的一个“实例”，a是Person的一个实例
# 这里b也是一个Person类，但它是独一无二的，即你修改Person不会影响到b，反之亦然
mp 'Person.new.metaclass', '<Class:#<Person:0xb76f3800>>'
p b # => #<Class:#<Person:0xb76f3800>>

mp 'Person.new.metaclass2', '#<Person:0xb76f3800>'
p c

mp 'Person.new.sss', 'sss in class << self'
a.sss 

mp 'b.class', 'Class'
p b.class # => Class



class Person
  def hello
    p 'hello Person'
  end
end

class << b
  def hello
    p 'hello b'
  end
end

class << c
  def hello
    p 'hello c'
  end
end

mp 'b.hello', 'hello b'
b.hello # => hello b  因为class << b 向b这个单例对象添加的方法，不会影响到Person类中定义的方法

mp 'c', '#<Person:0xb76f3800>'
p c # => #<Person:0xb76f3800>

mp 'c.class', 'Person'
p c.class # => Person

mp 'c.hello', 'hello c'
c.hello # => hello c  同理b，因为class << c 向c这个单例对象添加的方法，不会影响到Person类中定义的方法

d = Person.new
mp 'd.hello', 'hello person'
d.hello


class Person
  def self.hello
    p 'hello'
  end

  class << self
    # 看了最上面self和context的关系，你应该知道这个self代表是Person类
    # 在这里为Person添加方法，其实也就是为Person添加类方法，和上面的self.hello异曲同工
    def work
      p 'hard work'
    end
  end
end

mp 'Person.hello', 'hello'
Person.hello
mp 'Person.work', 'hard work'
Person.work



































