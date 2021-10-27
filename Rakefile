# -*- ruby -*-

require 'rubygems/package_task'
require 'fileutils'
require 'rake/clean'
require 'rake/testtask'
require_relative 'lib/kramdown-parser-gfm'

task :default => :test
Rake::TestTask.new do |test|
  test.warning = false
  test.libs << 'test'
  test.test_files = FileList['test/test_*.rb']
end

# Release tasks and development tasks ############################################

CLOBBER << "VERSION"
file 'VERSION' do
  puts "Generating VERSION file"
  File.open('VERSION', 'w+') {|file| file.write(Kramdown::Parser::GFM::VERSION + "\n")}
end

CLOBBER << 'CONTRIBUTERS'
file 'CONTRIBUTERS' do
  puts "Generating CONTRIBUTERS file"
  `echo   Count Name > CONTRIBUTERS`
  `echo ======= ==== >> CONTRIBUTERS`
  merge_maintainer_entries = "sed 's/ashmaroli@users.noreply.github.com/ashmaroli@gmail.com/'"
  %x(git log | grep ^Author: | sed 's/^Author: //' | #{merge_maintainer_entries} | sort | uniq -c | sort -nr >> CONTRIBUTERS)
end

# initialize `spec` for backwards compatibility.
gemspec_file = File.expand_path('kramdown-parser-gfm.gemspec', __dir__)
gemspec_contents = File.read(gemspec_file)
spec = eval(gemspec_contents, TOPLEVEL_BINDING.dup, gemspec_file)

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

task :test_gemspec do
  puts spec.to_ruby
end

task :changelog do
  changelog_file = File.expand_path('CHANGELOG.md', __dir__)
  release_stamp  = "#{Kramdown::Parser::GFM::VERSION} / #{Time.now.strftime('%Y-%m-%d')}"
  changelog_text = File.read(changelog_file).sub!("## HEAD\n\n", "## #{release_stamp}\n\n")

  if changelog_text
    puts 'Updating changelog for release..'
    File.open(changelog_file, 'wb') { |f| f.puts(changelog_text) }
    puts ''
    puts 'Updating Git index..'
    sh "git add #{changelog_file} --update"
  else
    puts 'No changes logged since last release!'
    abort
  end
end

desc 'Release version ' + Kramdown::Parser::GFM::VERSION
task :release => [:changelog, :clobber, :package, :publish_files]

desc "Upload the release to Rubygems"
task :publish_files => [:package] do
  sh "gem push pkg/kramdown-parser-gfm-#{Kramdown::Parser::GFM::VERSION}.gem"
  puts 'done'
end
