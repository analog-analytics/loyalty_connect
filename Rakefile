require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/lib/**/*_test.rb'
  t.verbose = false
  t.loader = :rake
end

task :default => :test
