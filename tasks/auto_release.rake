desc "Perform an end-to-end release of the gem"
task :auto_release do
  clean_up() # Clean up before we start
  Rake::Task[:bump_version].execute
  Rake::Task[:build].execute
  Rake::Task[:tag].execute
  Rake::Task[:publish].execute
  clean_up() # Clean up after we complete
end