desc "Publish the gem"
task :publish do
  load 'downloadr/version.rb'
  puts "[+] Publishing Downloadr version #{Downloadr::VERSION}"  
  Dir.glob("*.gem").each { |f| puts `gem push #{f}`} 
end