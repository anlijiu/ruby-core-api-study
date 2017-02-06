#!/usr/bin/env ruby -w
#
#
#原来ruby 里压根就没有类阿 ，都你妈是对象阿，  class Foo ;end  这就是出来个Class 的对象叫Foo 阿
#Class 是啥 ？ 也是个对象阿 

p Time.now

fred = Class.new do
  def meth1
    "hello"
  end
  def meth2
    "bye"
  end
end

a = fred.new     #=> #<#<Class:0x100381890>:0x100376b98>
p a.meth1          #=> "hello"
p a.meth2          #=> "bye"


module M
  N = 1
end

class C
  include M

  def self.foo
    puts N
  end

  class << self
    def bar
      puts "class << self,  dynimac def bar !!!"
    end
  end
end

C.foo
C.bar

class Foo
  class << self
    a = "aaaa"
    define_method :puts_a do
      puts a
    end
    def b
    end
  end
end

Foo.puts_a  #=> "aaaa"

class Bar
  a = "aaaa"
  class << self
    def test
      puts "Bar test"
    end
    define_method :puts_a do
      puts a
    end
    def b
    end
  end
end

Bar.test
# Bar.puts_a  #=> error
#=======================================================================================

klass = Class.new do
  def initialize(*args)
    @initialized = true
  end

  def initialized?
    @initialized || false
  end
end

p "klass.allocate.initialized? => #{klass.allocate.initialized?}" #=> false

#alias 为ruby 关键字， 按照linux shell 中alias 理解
class Class
  alias old_new new
  def new(*args)
    print "Creating a new ", self.name, "\n"
    old_new(*args)
  end
end

class Name
end

#Name 重新定义了new 的行为， 即打印后再new个对象
n = Name.new

#====================================================================================
p File.superclass          #=> IO
p IO.superclass            #=> Object
p Object.superclass        #=> BasicObject
class Foo; end
class BBar < Foo; end
p BBar.superclass           #=> Foo
p BasicObject.superclass   #=> nil

=begin
                         +---------+             +-...
                         |         |             |
         BasicObject-----|-->(BasicObject)-------|-...
             ^           |         ^             |
             |           |         |             |
          Object---------|----->(Object)---------|-...
             ^           |         ^             |
             |           |         |             |
             +-------+   |         +--------+    |
             |       |   |         |        |    |
             |    Module-|---------|--->(Module)-|-...
             |       ^   |         |        ^    |
             |       |   |         |        |    |
             |     Class-|---------|---->(Class)-|-...
             |       ^   |         |        ^    |
             |       +---+         |        +----+
             |                     |
obj--->OtherClass---------->(OtherClass)-----------...
=end

#有趣阿！不像c/c++ java  不会有重复定义一说， 多个定义Foo 的地方直接融合了  哈。
class Foo
  def ppp
    p "Foo ppp"
    self
  end
end

class Foo
  def self.inherited(subclass)
    puts "New subclass: #{subclass}"
  end
  def pppp
    p "Foo     pppp"
    self
  end
end

#这个打印出"New subclass: Bar"
class Barr < Foo
  def tttest
    p "Barr tttest"
  end
end

#这个没有打印出New subclass: Baz 和ruby-doc 上说的不符合阿！
class Baz < Barr
end

Baz.new.ppp.pppp
p Baz.new.methods
p Baz.instance_methods



# class C
# end 
# ruby中 这一段代码看起来像是在定义未来C.new 对象的行为方式 实际上不是！！！！！
# 实际上这就是运行了一段代码
class C
end
p C.singleton_class?                  #=> false
p C.singleton_class.singleton_class?  #=> true
c = C.new
p c.class
p c.class.singleton_class
p c.singleton_class
p c.singleton_class.singleton_class


@@foo = 1
p "Object @@foo is #{@@foo}"   #=>  1
class Fred
  @@foo = 99
end
p "Object @@foo is #{@@foo}"   #=>  99
# 之所以出现这样的行为 因为  @@foo  根本不属于某个类！！！ 这玩意属于ruby 的类体系结构
# 坑爹阿！   说好的类变量呢



p "Fred.class_variable_defined?(:@@foo)  => #{Fred.class_variable_defined?(:@@foo)}"    #=> true
p "Fred.class_variable_get(:@@foo) => #{Fred.class_variable_get(:@@foo)}"     #=> 99
p Fred.class_variable_defined?(:@@bar)    #=> false



class One
  @@var1 = 1
end
class Two < One
  @@var2 = 2
end
#默认取所有类成员， 包括继承 ， 传false 的话便不算继承的类成员
p One.class_variables          #=> [:@@var1]
p Two.class_variables          #=> [:@@var2, :@@var1]
p Two.class_variables(false)   #=> [:@@var2]


