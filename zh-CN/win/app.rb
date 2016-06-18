gsub_file 'Gemfile', /^source .*$/, ""
add_source "http://ruby.sdutlinux.org"

devkit = 0
begin
  require 'devkit'
rescue LoadError 
 case devkit
 when 0
 begin
  puts "需要Devkit，但似乎并未正确安装"
  if r = ask("请问是否已经下载DevKit，如果有请输入路径，如C:/devkit [无]", :red, :red, :on_black, :bold)
    system "ruby #{r}/dk.rb init"
    require 'yaml'    
    yaml = YAML.load File.read "../config.yml"
    yaml << File.expand_path("..", RbConfig::CONFIG['bindir'])
    open("../config.yml", "w") do |f| f.write YAML.dump yaml end
    system "ruby #{r}/dk.rb install"
  end
 rescue 
 end
  devkit = 1
  retry
 when 1
  if yes?("请问需要通过浏览器打开网址以便下载一份吗？", :red, :on_black, :bold)
    system "start http://rubyinstaller.org/downloads/"
    puts "在解压和安装DevKit之后，请重新运行rails new"
    exit!
  end
 end
end


