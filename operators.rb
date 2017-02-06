#!/usr/bin/env ruby
require 'pp'


a = "Ruby"       # 一个字符串对象。
b = c = 'Ruby'
pp "a = 'Ruby'"
pp "b = c = 'Ruby'"                            # 两个字符串对象指向动一个引用。"
pp "a.equal?(b)     ----> #{a.equal?(b) }"     # false: a和b是不同的对象。
pp "b.equal?(c)     ----> #{b.equal?(c)}"      # true: b和c指向同一个引用。
pp "a == b ?        ----> #{a == b} "          # true ， a 和b 值相同

pp "(1..10) === 5   ----> #{(1..10) === 5}"    # true: 5属于range 1..10
pp "/\d+/ === '123'  ----> #{/\d+/ === "123"}"  # true: 字符串匹配这个模式
pp "String === 's'  ----> #{String === "s"}"   # true: "s" 是一个字符串类的实例
pp ":s === 's' ?    ----> #{:s === 's'}"       # false
pp ":s == 's' ?     ----> #{:s == 's'}"        # false

status = :all

case status
when :all
  pp "status is :all"
end

aa = 
  if status.equal? :all
    "true  status.equal :all"
  else
    "false status.equal :all"
  end
pp aa
