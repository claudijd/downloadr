require 'bundler/gem_tasks'
require 'rubygems'
require 'rake'
require 'rubygems/package_task'
require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'

$:.unshift File.join(File.dirname(__FILE__), "lib")

task :default => :spec

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec)

def clean_up
  Dir.glob("*.gem").each { |f| File.unlink(f) }
  Dir.glob("*.lock").each { |f| File.unlink(f) }  
end

def bump_minor_version
  version_string_match = File.read('lib/downloadr/version.rb').match(/VERSION='(\d+\.\d+\.)(\d+)'/)

  version_prefix = version_string_match[1]
  existing_patch_version = version_string_match[2]
  new_patch_version = (existing_patch_version.to_i + 1).to_s
  new_version = version_prefix + new_patch_version

  File.open('lib/downloadr/version.rb', 'w') do |f|
    f.puts "module Downloadr\n"
    f.puts "  VERSION='#{new_version}'\n"
    f.puts "end"
  end

  puts "[+] Bumping Downloadr version #{new_version}"
  puts `git add lib/downloadr/version.rb`
  puts `git commit -a -m "Bumped Gem version to #{new_version}"`
  puts `git push origin master`
end

bump_minor_version
exit

desc "Build the gem"
task :build do
  require 'downloadr/version.rb'
  puts "[+] Building Downloadr version #{Downloadr::VERSION}"
  puts `gem build downloadr.gemspec`
end

desc "Publish the gem"
task :publish do
  require 'downloadr/version.rb'
  puts "[+] Publishing Downloadr version #{Downloadr::VERSION}"  
  Dir.glob("*.gem").each { |f| puts `gem push #{f}`} 
end

desc "Tag the release"
task :tag do
  require 'downloadr/version.rb'
  puts "[+] Tagging Downloadr version #{Downloadr::VERSION}"  
  `git tag #{Downloadr::VERSION}`
  `git push --tags`
end

desc "Perform an end-to-end release of the gem"
task :release do
  clean_up() # Clean up before we start
  bump_minor_version()

  require 'downloadr/version.rb'
  Rake::Task[:build].execute
  Rake::Task[:tag].execute
  Rake::Task[:publish].execute
  clean_up() # Clean up after we complete
end