#!/usr/bin/env ruby

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
