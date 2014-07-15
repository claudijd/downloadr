desc "Bump the gem's version"
task :bump_version do
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