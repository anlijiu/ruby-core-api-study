#!/usr/bin/env ruby

p "IO::SEEK_CUR => #{IO::SEEK_CUR}"
p "IO::EWOULDBLOCKWaitReadable => #{IO::EWOULDBLOCKWaitReadable}"

require 'io/console'
rows, columns = $stdin.winsize
puts "Your screen is #{columns} wide and #{rows} tall"

p IO.binread("testfile")           #=> "This is line one\nThis is line two\nThis is line three\nAnd so on...\n"
p IO.binread("testfile", 20)       #=> "This is line one\nThi"   读取20个字符
p IO.binread("testfile", 20, 10)   #=> "ne one\nThis is line "   从第10个字符开始读取20个字符

IO.foreach("testfile") {|x| print "GOT ", x }    #每行读取 然后打印 GOT + 行内容


#copy_stream(src, dst) 
#copy_stream(src, dst, copy_length)
#copy_stream(src, dst, copy_length, src_offset)
IO.copy_stream("testfile", "testfile1")


fd = IO.sysopen("/dev/tty", "w")
a = IO.new(fd,"w")
$stderr.puts "Hello"
a.puts "World"

require 'fcntl'

fdd = STDERR.fcntl(Fcntl::F_DUPFD)
#io = IO.new(fdd, mode: 'w:UTF-8', cr_newline: true)
io = IO.new(fdd, mode: 'w:UTF-16LE', cr_newline: false)   #在我的终端CR 打不出来东西， 只能用默认的EOL
io.puts "Hello, World!"
io.close

fd = STDERR.fcntl(Fcntl::F_DUPFD)
io = IO.new(fd, mode: 'w', cr_newline: false,
                        external_encoding: Encoding::UTF_16LE)
io.puts "Hello, World!"


p "===================================="

rd, wr = IO.pipe
if fork
  wr.close
  puts "Parent got: <#{rd.read}>"
  rd.close
  Process.wait
else
  rd.close
  puts "Sending message to parent"
  wr.write "Hi Dad"
  wr.close
end



