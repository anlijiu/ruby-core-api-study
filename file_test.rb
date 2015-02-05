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

