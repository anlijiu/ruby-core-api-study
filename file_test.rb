#!/usr/bin/env ruby
require 'pathname'
require 'find'

p File.absolute_path("~oracle/bin")
p File.atime("file_test.rb") 
p File.basename("/home/gumby/work/ruby.rb")          #=> "ruby.rb"
p File.basename("/home/gumby/work/ruby.rb", ".rb")   #=> "ruby"
p File.basename("/home/gumby/work/ruby.rb", ".*")    #=> "ruby"
#p File.birthtime("file_test.rb")   #undefine method , why ??
#File.chmod(0644, "file_test.rb", "out")   #=> 2
#chown  user_id ,group_id, filename...
#File.chown(1000, 100, "file_test.rb")
p File.ctime("file_test.rb")
p File.directory?(".")

d = File.open(".")

#当前目录绝对路径
realpath = Pathname.new(File.dirname(__FILE__)).realpath
#加了 ** 之后匹配任意层级目录
pattern = '**/*.rb'
=begin
#本代码块给当前目录下所有.rb文件头部添加"#!/usr/bin/env ruby"
Find.find('./') { |path| 
  if File.fnmatch(pattern, path,  File::FNM_PATHNAME | File::FNM_DOTMATCH) 
    new_file = path + ".new"
    original_file  = path
    File.open(new_file, 'w') do |fo|
      fo.puts "#!/usr/bin/env ruby\n\n"
      File.foreach(original_file) do |li|
        fo.puts li
      end
    end

    File.rename(original_file,  original_file + ".old")
    File.rename(new_file, original_file)
  end
  #puts path unless File.directory?(path)
}
=end

p File.split("/home/anlijiu/me.profile")   #=> ["/home/anlijiu", "me.profile"]
p File.stat("out").mtime   #=> Tue Apr 08 12:58:04 CDT 2003

f = File.new("out", "w")
p f.write("1234567890")     #=> 10    无论out里面之前有啥内容， 全抹除然后写入1234567890
f.close                     #=> nil
p File.truncate("out", 5)   #=> 0    将文件变成指定大小的长度， 小于源文件大小的话从尾部截取， 大于源文件大小的话从尾部添加hole
p "File.size('out') => #{File.size("out")}"      #=> 5
File.umask(0016)   #=> 2      umask 8进制， 0016 => 14
p File.umask         #=> 14
p File.join("usr", "mail", "gumby")   #=> "usr/mail/gumby"

open("a", "w") {}
p File.identical?("a", "a")      #=> true
p File.identical?("a", "./a")    #=> true
File.link("a", "b")              #硬链接
p File.identical?("a", "b")      #=> true
File.symlink("a", "c")           #软链接
p File.identical?("a", "c")      #=> true
open("d", "w") {}
p File.identical?("a", "d")      #=> false


p File.symlink("out", "link2out")   #=> 0     软链接
p File.stat("out").size              #=> 66
p File.lstat("link2out").size            #=> 8
p File.stat("link2out").size             #=> 66
File.delete("a", "b", "c", "d", "link2out")
p File.new("out").mtime
p File.new("out").size













