#!/usr/bin/env ruby

# 总结一下，Ruby的不同之处在于：
# 1. 父类的的private和protected都可以被子类所继承
# 2. protected和private一样不能被显式调用
# 3. protected和private的区别是protected可以在类的其他方法中以实例形式调用(如: obj.protectedMethod)，而private不行
class ClassSuper  
    attr_accessor :attr1  
    def initialize  
        @attr1 = "attr1"  
    end  
  
    private  
    def privateMethod  
        puts "this is private"  
    end  
  
    #protected = private which cannot be called directly  
    protected  
    def protectedMethod  
        puts "this is protected"  
    end  
end  
  
class ClassChild < ClassSuper  
  
    public   
    def callProtected  
        protectedMethod  
    end  
  
    def callPrivate  
        privateMethod  
    end  
  
    def objProtected obj  
        obj.protectedMethod  
    end  
      
    #this is invalid  
    def objPrivate obj  
        obj.privateMethod  
    end  
end  
  
a = ClassChild.new  
puts a.attr1  
a.callProtected  
a.callPrivate #private method is also inherited  
#a.privateMethod #fail  
#a.protectedMethod #fail  
  
a.objProtected a  
#a.objPrivate a #this is the difference between protec
