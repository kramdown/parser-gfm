# frozen_string_literal: true

require_relative 'lib/kramdown/parser/gfm'

Gem::Specification.new do |s|
  s.name     = 'kramdown-parser-gfm'
  s.version  = Kramdown::Parser::GFM::VERSION
  s.authors  = ['Thomas Leitner']
  s.email    = ['t_leitner@gmx.at']
  s.homepage = 'https://github.com/kramdown/parser-gfm'
  s.license  = 'MIT'
  s.summary  = 'A kramdown parser for the GFM dialect of Markdown'

  s.files = Dir.glob('{lib,test}/**/*').concat(%w[COPYING VERSION CONTRIBUTERS])
  s.require_path = 'lib'

  s.required_ruby_version = '>= 2.5.0'

  s.add_runtime_dependency 'kramdown', '~> 2.0'
end
