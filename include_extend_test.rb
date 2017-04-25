#!/usr/bin/env ruby -w

# include主要用来将一个模块插入（mix）到一个类或者其它模块。 
# extend 用来在一个对象（object，或者说是instance）中引入一个模块，这个类从而也具备了这个模块的方法。 
# 通常引用模块有以下3种情况： 
# 1.在类定义中引入模块，使模块中的方法成为类的实例方法 
# 这种情况是最常见的 
# 直接 include <module name>即可 , 实例可调用该模块定义的方法
#
# 2.在类定义中引入模块，使模块中的方法成为类的类方法 
# 这种情况也是比较常见的 
# 直接 extend <module name>即可 ,  类可调用该模块定义的方法，相当于static
#
# 3.在类定义中引入模块，既希望引入实例方法，也希望引入类方法 
# 这个时候需要使用 include, 
#   但是在模块中对类方法的定义有不同，定义出现在 方法 
# def self.included(c) ... end 中 
#
module Ma   
  MA_VALUE = 1  
  def ma_1   
    puts "it is ma_1"  
  end   
end   
  
module Mb   
  MB_VALUE = 1  
  def self.included(c)   # 其他类include 该模块后便具有了   mb_2 static 方法
    def c.mb_2   
      puts "it is mb_2"  
    end   
  end   
  def mb_1   
    puts "it is mb_1"  
  end   
end   
  
class Ca   
  include Ma      
end   
     
class Cb   
  extend Ma   
  include Mb   
end   
  
c1 = Ca.new  
c1.ma_1
  
c2 = Cb.new  
c2.mb_1   

Cb.ma_1   
Cb.mb_2   

  
puts Ma::MA_VALUE   
puts Ca::MA_VALUE   
  
puts Mb::MB_VALUE   
puts Cb::MB_VALUE  
