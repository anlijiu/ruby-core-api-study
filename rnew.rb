#!/usr/bin/env ruby

#本文件打开一个文件 写入#!/usr/bin/env ruby 之后给此文件添加可执行属性

path = ARGV[0]
fail "specify filename to create" unless path

def rnew(path)
  File.open(path, "w") { |f| f.puts "#!/usr/bin/env ruby\n\n" } 
  File.chmod(0755, path)
  system "vim", path
end

if FileTest::exist?(path)
  system "vim", path
else rnew(path)
end
