#!/usr/bin/env ruby

p "IO::SEEK_CUR => #{IO::SEEK_CUR}"
p "IO::EWOULDBLOCKWaitReadable => #{IO::EWOULDBLOCKWaitReadable}"

require 'io/console'
rows, columns = $stdin.winsize
puts "Your screen is #{columns} wide and #{rows} tall"

#和read 一样， 但是二进制模式  ASCII-8BIT编码 
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
# pipe → [read_io, write_io] click to toggle source
# pipe(ext_enc) → [read_io, write_io]
# pipe("ext_enc:int_enc" [, opt]) → [read_io, write_io]
# pipe(ext_enc, int_enc [, opt]) → [read_io, write_io]
# pipe(...) {|read_io, write_io| ... } 
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

 # popen([env,] cmd, mode="r" [, opt]) → io click to toggle source
 # popen([env,] cmd, mode="r" [, opt]) {|io| block } → obj 
 # 子进程run cmd
# set IO encoding
#IO.popen("nkf -e out", :external_encoding=>"EUC-JP") {|nkf_io|
#  euc_jp_string = nkf_io.read
#}

# merge standard output and standard error using
# spawn option.  See the document of Kernel.spawn.
require 'pp'
IO.popen(["ls", "/", :err=>[:child, :out]]) {|ls_io|
  ls_result_with_error = ls_io.read
  #pp ls_result_with_error 
}

# spawn options can be mixed with IO options
IO.popen(["ls", "/"], :err=>[:child, :out]) {|ls_io|
  ls_result_with_error = ls_io.read
  puts ls_result_with_error
}

f = IO.popen("uname")
p f.readlines
f.close
puts "Parent is #{Process.pid}"
IO.popen("date") { |f| puts f.gets }
IO.popen("-") {|f| $stderr.puts "#{Process.pid} is here, f is #{f.inspect}"}
p $?
IO.popen(%w"sed -e s|^|<foo>| -e s&$&;zot;&", "r+") {|f|
  f.puts "bar"; f.close_write; puts f.gets
}

p IO.read("out", mode: "rb")
a = IO.readlines("testfile")
p a[0]   #=> "This is line one\n"

# begin
#   result = io_like.read_nonblock(maxlen)
# rescue IO::WaitReadable
#   IO.select([io_like])
#   retry
# rescue IO::WaitWritable
#   IO.select(nil, [io_like])
#   retry
# end
