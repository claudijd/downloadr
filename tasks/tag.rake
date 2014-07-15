desc "Tag the release"
task :tag do
  load 'downloadr/version.rb'
  puts "[+] Tagging Downloadr version #{Downloadr::VERSION}"  
  puts `git tag #{Downloadr::VERSION}`
  puts `git push --tags`
end