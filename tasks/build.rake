desc "Build the gem"
task :build do
  load 'downloadr/version.rb'
  puts "[+] Building Downloadr version #{Downloadr::VERSION}"
  puts `gem build downloadr.gemspec`
end