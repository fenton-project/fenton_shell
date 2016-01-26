require 'bundler/gem_tasks'
require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'yard'
require 'cucumber'
require 'cucumber/rake/task'
require 'rubocop/rake_task'
require 'digest/sha2'

RuboCop::RakeTask.new

# http://www.rubydoc.info/gems/yard/file/docs/Tags.md

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb', '-', 'bin/**/*']
  t.stats_options = ['--list-undoc']
end

spec = eval(File.read('fenton_shell.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

CUKE_RESULTS = 'coverage/results.html'.freeze
CLEAN << CUKE_RESULTS

desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts = opts
  t.fork = false
end

desc 'Run features tagged as work-in-progress (@wip)'
Cucumber::Rake::Task.new('features:wip') do |t|
  tag_opts = ' --tags ~@pending'
  tag_opts += ' --tags @wip'
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} " \
    "--format pretty -x -s#{tag_opts}"
  t.fork = false
end

task cucumber: :features
task 'cucumber:wip' => 'features:wip'
task wip: 'features:wip'
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
end

name = Gem::PackageTask.new(spec).name

desc "Write checksum for #{name}.gem file"
task 'package:checksum' do
  built_gem_path = "pkg/#{name}.gem"
  checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
  checksum_path = "checksum/#{name}.gem.sha512"
  File.open(checksum_path, 'w' ) {|f| f.write(checksum) }
end

task default: [:test, :features]
