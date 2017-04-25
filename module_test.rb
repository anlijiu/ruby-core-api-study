#!/usr/bin/env ruby
require 'awesome_print'

module Mod
  include Math
  CONST = 1
  def meth
    #  ...
  end
end
p Mod.class              #=> Module
p Mod.constants          #=> [:CONST, :PI, :E]
p Mod.instance_methods   #=> [:meth]

p Module.constants.first(4) # => [:Object, :Module, :Class, :BasicObject]

p Module.constants.include?(:SEEK_SET)   # => false

class IO
  Module.constants.include?(:SEEK_SET) # => true
end

module M1
  module M2
    $a = Module.nesting
  end
end
p $a           #=> [M1::M2, M1]
p $a[0].name   #=> "M1::M2"

fred = Module.new do
  def meth1
    "hello"
  end
  def meth2
    "bye"
  end
end
a = "my string"
p a.extend(fred)   #=> "my string"
p a.meth1          #=> "hello"
p a.meth2          #=> "bye"

module Mod
  include Math
  include Comparable
  prepend Enumerable
end

#打印出mixin module 顺序包括它的本体， 可以看出 prepend 加入的在前， include 加入的在本体之后
#所以之后的调用顺序也是这个顺序  见 inheritance_test.rb
p Mod.ancestors        #=> [Enumerable, Mod, Comparable, Math]
p Math.ancestors       #=> [Math]
p Enumerable.ancestors #=> [Enumerable]

#autoload(module, filename) → nil
module A
end
A.autoload(:B, "./b.rb")
A::B.doit            # autoloads "b"
p A.autoload?(:B)            #=> "b"


class Thing
end
a = %q{def hello() "Hello there!" end}
Thing.module_eval(a)   #将一个代码块作为module 的形式mixin进class Thing
puts Thing.new.hello()
#Thing.module_eval("invalid code", "dummy", 123)   => dummy:123:in `module_eval': undefined local variable or method `code' for Thing:Class





class Thing
end
Thing.class_exec {            #给class Thing追加实例方法
  def hello1() "Hello1 there!" end
}
puts Thing.new.hello1()




class Fred
  def foo
    @@foo
  end
end
Fred.class_variable_set(:@@foo, 101)     #=> 101
p "Fred.new.foo => #{Fred.new.foo}"                       #=> 101





#查看常量 const , 第一个参数为常量名， 第二个参数为是否从继承关系的类中查找,默认为true
p Float.const_defined?(:EPSILON)      #=> true, found in Float itself
p Float.const_defined?("String")      #=> true, found in Object (ancestor)
p BasicObject.const_defined?(:Hash)   #=> false

p "Math.const_defined?(:String) => #{Math.const_defined?(:String)}"   #=> true, found in Object

module Admin
  autoload :User, 'admin/user'
end
p "Admin.const_defined?(:User) => #{Admin.const_defined?(:User) }"  #=> true
p IO.const_defined?(:SYNC)          #=> true, found in File::Constants (ancestor)
p IO.const_defined?(:SYNC, false)   #=> false, not found in IO itself
begin p "Hash.const_defined? 'foobar'  => #{ Hash.const_defined? 'foobar'}"   #=> NameError: wrong constant name foobar
rescue NameError
  p "rescue NameError from Hash.const_defined? 'foobar'"
end
p Math.const_get(:PI)   #=> 3.14159265358979

module Foo; class Bar; end end
p Object.const_get 'Foo::Bar'   #=> Foo::Bar

module Foo
  class Bar
    VAL = 10
    def bla
      
    end
  end

  class Baz < Bar; end
end

p "===============begen"
p Foo::Bar.new.methods
p "===============end"

p "Object.const_get 'Foo::Baz::VAL' => #{Object.const_get 'Foo::Baz::VAL'}"         # => 10
begin
  p "Object.const_get 'Foo::Baz::VAL', false  => #{Object.const_get 'Foo::Baz::VAL', false}"  # => NameError
rescue NameError
  p "NameError from Object.const_get 'Foo::Baz::VAL', false"
end

begin
  p Object.const_get 'foobar' #=> NameError: wrong constant name foobar
rescue NameError
  p "rescue NameError Object.const_get 'foobar'"
end



def Foo.const_missing(name)
    name # return the constant name as Symbol
end
p Foo::UNDEFINED_CONST    #=> :UNDEFINED_CONST: symbol returned

def Object.const_missing(name)
  @looked_for ||= {}
  str_name = name.to_s
  raise "Class not found: #{name}" if @looked_for[str_name]
  @looked_for[str_name] = 1
  file = str_name.downcase
  #require file
  klass = const_get(name)
  return klass if klass
  raise "Class not found: #{name}"
end

#p Object::UNDEFINED_CONST  => ./module_test.rb:169:in `const_missing': Class not found: UNDEFINED_CONST (RuntimeError)

Math.const_set("HIGH_SCHOOL_PI", 22.0/7.0)   #=> 3.14285714285714
p Math::HIGH_SCHOOL_PI - Math::PI              #=> 0.00126448926734968

#Object.const_set('foobar', 42) #=> NameError: wrong constant name foobar

module A1
end
class B1
  include A1
end
class C1 < B1
end
p B1.include?(A1)   #=> true
p C1.include?(A1)   #=> true
p A1.include?(A1)   #=> false

p "=================================================================="

module A
  def method1()  end
end
class B
  def method2()  end
end
class C < B
  include A
  def method3()  end
end

p A.method_defined? :method1    #=> true
p C.method_defined? "method1"   #=> true
p C.method_defined? "method2"   #=> true
p C.method_defined? "method3"   #=> true
p C.method_defined? "method4"   #=> false

p "=================================================================="
module Mixin
end

module Outer
  include Mixin
end
p Mixin.included_modules   #=> []
p Outer.included_modules   #=> [Mixin]

class Interpreter
  def do_a() print "there, "; end
  def do_d() print "Hello ";  end
  def do_e() print "!\n";     end
  def do_v() print "Dave";    end
  Dispatcher = {                     # 这里都是unbound methods
    "a" => instance_method(:do_a),
    "d" => instance_method(:do_d),
    "e" => instance_method(:do_e),
    "v" => instance_method(:do_v)
  }
  def interpret(string)
    string.each_char {|b| Dispatcher[b].bind(self).call }   #在这里将这些unbound methods 绑定到对象上然后调用 这种脱裤子放屁的用法到底是为啥阿。。。
  end
end

interpreter = Interpreter.new
interpreter.interpret('dave')   #=> Hello there, Dave!

p "=====================实例方法演示========================"
module A
  def method1()  end
end
class B
  include A
  def method2()  end
end
class C < B
  def method3()  end
end

p A.instance_methods(false)                   #=> [:method1]
p B.instance_methods(false)                   #=> [:method2]
p B.instance_methods(true).include?(:method1) #=> true
p C.instance_methods(false)                   #=> [:method3]
p C.instance_methods.include?(:method2)       #=> true



class SimpleSingleton  # Not thread safe
  private_class_method :new
  def SimpleSingleton.create(*args, &block)
    @me = new(*args, &block) if ! @me
    @me
  end
end

s = SimpleSingleton.create
f = SimpleSingleton.create
p "f == s ? => #{f==s}"

module Modd
  def method1()  end
  private :method1
  def method2()  end
end
#实例方法 和私有实例方法
p Modd.instance_methods           #=> [:method2]
p Modd.private_instance_methods   #=> [:method1]



p "=====================私有实例方法无法继承调用演示========================"
module A
  def method1()  end
end
class B
  private
  def method2()  end
end
class C < B
  include A
  def method3()  end
end

p A.method_defined? :method1            #=> true
p C.private_method_defined? "method1"   #=> false
p C.private_method_defined? "method2"   #=> true
p C.method_defined? "method2"           #=> false
begin
  C.new.method2
rescue NoMethodError
  p "私有方法没办法继承调用的 少年郎"
end


p "============================ protected 方法继承调用演示"

module A
  def method1()  end
end
class B
  protected
  def method2() p "protected method2 from B" end
end
class C < B
  include A
  def method3()  end
end

p A.method_defined? :method1              #=> true
p C.protected_method_defined? "method1"   #=> false
p C.protected_method_defined? "method2"   #=> true
p C.method_defined? "method2"             #=> true
p C.public_method_defined? "method2"   #=> false
begin
  C.new.method2
rescue NoMethodError
  p "protected 方法居然也没办法继承调用, 苍天阿  why？？？？"
end

p "========================= alias_method newname oldname  一句话 alias_method调用子类方法， alias 调用父类方法"
module Mod
  alias_method :orig_exit, :exit
  def exit(code=0)
    puts "Exiting with code #{code}"
    #orig_exit(code)   执行就真退了。。。
  end
end
include Mod
exit(99)


module Moddd
    attr_accessor(:one, :two)
end
p Moddd.instance_methods.sort   #=> [:one, :one=, :two, :two=]


class AA
  def fred
    puts "In Fred"
  end
  def create_method(name, &block)
    self.class.send(:define_method, name, &block)
    #self.class.define_method(name, &block)  =>  private method `define_method' called for BB:Class (NoMethodError)
    #也就是说需要用send  这样才是在BB的领域调用define_method， 然后b 才能用
  end
  define_method(:wilma) { puts "Charge it!" }
end
class BB < AA
  define_method(:barney, instance_method(:fred))

  define_method :mmmm do |*args, &block|
    ap args
    ap block
  end
end
b = BB.new
b.barney
b.wilma
b.create_method(:betty) { p self }
b.betty
# BB.action(:mmmm).call({ :aa => "asdfasdf", :bb => "asdfasdf"})
# b.mmmm({ :aa => "asdfasdf", :bb => "asdfasdf"})

module Picky
  def Picky.extend_object(o)
    if String === o
      puts "Can't add Picky to a String"
    else
      puts "Picky added to #{o.class}"
      super
    end
  end
end
p Array.new.class
(s = Array.new).extend Picky  # Call Object.extend   调用到Picky.extend_object(Array.new)   于是打印出"Picky added to #{Array.new.class}" 
(s = "quick brown fox").extend Picky




module A
  def self.extended(mod)
    puts "#{self} extended in #{mod}"
  end
  def self.method_added(method_name)
    puts "Adding #{method_name.inspect}"
  end
  def self.method_removed(method_name)
    puts "Removing #{method_name.inspect}"
  end
  def self.some_class_method() end
  def some_instance_method() end
  class << self
    remove_method :some_class_method
  end
  remove_method :some_instance_method
end

module Enumerable
  extend A
end
class T 
  prepend A
end
begin
  T.new.some_instance_method 
rescue NoMethodError
  p "some_instance_method has been removed !!! so  no method some_instance_method"
end
# => prints "A extended in Enumerable"






module Mod
  def one
    p "This is one"
  end
  module_function :one   #加了这个下面再定义 one 也不会覆盖本次定义的
end
class Cls
  include Mod
  def call_one
    one
  end
end
Mod.one     #=> "This is one"
c = Cls.new
c.call_one  #=> "This is one"
module Mod
  def one
    p "This is the new one"
  end
end
Mod.one     #=> "This is one"
c.call_one  #=> "This is the new one"

#prepended callback
module A
  def self.prepended(mod)
    puts "#{self} prepended to #{mod}"
  end
end
module Enumerable
  prepend A
end
# => prints "A prepended to Enumerable"

module Mod2
  def a()  end
  def b()  end
  private
  def c()  end
  private :a
end
p Mod2.private_instance_methods   #=> [:a, :c]

class Parent
  def hello
    puts "In parent"
  end
end
class Child < Parent
  def hello
    puts "In child"
  end
end

c = Child.new
c.hello               # child's hello

class Child
  remove_method :hello  # remove from child, still in parent
end
c.hello               # parent's hello

class Child
  undef_method :hello   # prevent any calls to 'hello'
end
#c.hello               # 所有继承关系的hello 方法全没～
