class Klass
  def hello(*args)
    print "Hello " + args.join(' ') + "\n"
  end
end

module P
  def my_test
    print "module P -> my_test\n"
  end
end

#Klass.prepend P
Klass.send :prepend, P             #将module P 追加到Klass类里 （文艺青年用法） 和 Klass.prepend P 一样的效果
k = Klass.new
k.hello
k.my_test                          #所以这里Klass的对象才可以调用module P里定义的方法

#Klass.my_test                     #undefined method `my_test' for Klass:Class
