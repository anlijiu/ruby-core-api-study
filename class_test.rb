#!/usr/bin/env ruby 

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
class Bar < Foo; end
p Bar.superclass           #=> Foo
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
class Bar < Foo
end

#这个没有打印出New subclass: Baz 和ruby-doc 上说的不符合阿！
class Baz < Bar
end

Baz.new.ppp.pppp
