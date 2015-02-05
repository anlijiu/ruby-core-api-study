#!/usr/bin/env ruby



class Klass
  def hello(*args)
    print "Hello " + args.join(' ') + "\n"
  end
end

k = Klass.new
k.send :hello, "gentle", "readers"   #=> "Hello gentle readers"
