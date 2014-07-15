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

require 'downloadr/version'
VERSION = Downloadr::VERSION

desc "Bump the Gemspec Version"
task :bump do
  version_string_match = File.read('lib/downloadr/version.rb').match(/VERSION='(\d+\.\d+\.)(\d+)'/)

  version_prefix = version_string_match[1]
  existing_patch_version = version_string_match[2]
  new_patch_version = (existing_patch_version.to_i + 1).to_s
  VERSION = version_prefix + new_patch_version

  File.open('lib/downloadr/version.rb', 'w') do |f|
    f.puts "module Downloadr\n"
    f.puts "  VERSION='#{VERSION}'\n"
    f.puts "end"
  end

  puts "[+] Bumping Downloadr version #{VERSION}"
  puts `git add lib/downloadr/version.rb`
  puts `git commit -a -m "Bumped Gem version to #{VERSION}"`
  puts `git push origin master`
end

desc "Build the gem"
task :build do
  puts "[+] Building Downloadr version #{VERSION}"
  puts `gem build downloadr.gemspec`
end

desc "Publish the gem"
task :publish do
  puts "[+] Publishing Downloadr version #{VERSION}"  
  Dir.glob("*.gem").each { |f| puts `gem push #{f}`} 
end

desc "Tag the release"
task :tag do
  puts "[+] Tagging Downloadr version #{VERSION}"  
  `git tag #{VERSION}`
  `git push --tags`
end

desc "Perform an end-to-end release of the gem"
task :release do
  clean_up() # Clean up before we start
  Rake::Task[:bump].execute
  Rake::Task[:build].execute
  Rake::Task[:tag].execute
  Rake::Task[:publish].execute
  clean_up() # Clean up after we complete
end