# -*- ruby -*-

require 'rubygems/package_task'
require 'fileutils'
require 'rake/clean'
require 'rake/testtask'
require_relative 'lib/kramdown/parser/gfm'

task :default => :test
Rake::TestTask.new do |test|
  test.warning = false
  test.libs << 'test'
  test.test_files = FileList['test/test_*.rb']
end

# Release tasks and development tasks ############################################

SUMMARY = 'kramdown-parser-gfm provides a kramdown parser for the GFM dialect of Markdown'

PKG_FILES = FileList.new(['COPYING', 'VERSION', 'CONTRIBUTERS', 'lib/**/*.rb', 'test/**/*'])

CLOBBER << "VERSION"
file 'VERSION' do
  puts "Generating VERSION file"
  File.open('VERSION', 'w+') {|file| file.write(Kramdown::Parser::GFM::VERSION + "\n")}
end

CLOBBER << 'CONTRIBUTERS'
file 'CONTRIBUTERS' do
  puts "Generating CONTRIBUTERS file"
  `echo "  Count Name" > CONTRIBUTERS`
  `echo "======= ====" >> CONTRIBUTERS`
  `git log | grep ^Author: | sed 's/^Author: //' | sort | uniq -c | sort -nr >> CONTRIBUTERS`
end

spec = Gem::Specification.new do |s|
  s.name = 'kramdown-parser-gfm'
  s.version = Kramdown::Parser::GFM::VERSION
  s.summary = SUMMARY
  s.license = 'MIT'

  s.files = PKG_FILES.to_a

  s.require_path = 'lib'
  s.required_ruby_version = '>= 2.3'
  s.add_dependency 'kramdown', '~> 2.0'

  s.has_rdoc = true

  s.author = 'Thomas Leitner'
  s.email = 't_leitner@gmx.at'
  s.homepage = "https://github.com/kramdown/parser-gfm"
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

task :gemspec => ['CONTRIBUTERS', 'VERSION'] do
  print "Generating Gemspec\n"
  contents = spec.to_ruby
  File.write("kramdown-parser-gfm.gemspec", contents, mode: 'w+')
end
CLOBBER << 'kramdown-parser-gfm.gemspec'

task :gemfile do
  File.open('Gemfile', 'wb') do |f|
    f.puts <<~RUBY
      source 'https://rubygems.org'
      gemspec

      gem 'rake', '~> 12.0'
      gem 'minitest', '~> 5.0'
      gem 'rubocop', '~> 0.62.0'
    RUBY
  end
end

desc 'Generate gemspec and Gemfile for Continuous Integration'
task :bootstrap => [:gemspec, :gemfile]

desc 'Release version ' + Kramdown::Parser::GFM::VERSION
task :release => [:clobber, :package, :publish_files]

desc "Upload the release to Rubygems"
task :publish_files => [:package] do
  sh "gem push pkg/kramdown-parser-gfm-#{Kramdown::Parser::GFM::VERSION}.gem"
  puts 'done'
end
