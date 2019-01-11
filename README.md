# kramdown GFM parser

This is a parser for [kramdown](https://kramdown.gettalong.org) that converts
Markdown documents in the GFM dialect to HTML.

Note: Until kramdown version 2.0.0 this parser was part of the kramdown
distribution.


## Installation

~~~ruby
gem install kramdown-parser-gfm
~~~


## Usage

~~~ruby
require 'kramdown'
require 'kramdown/parser/gfm'

Kramdown::Document.new(text, input: 'GFM').to_html
~~~


## Development

Clone the git repository and you are good to go. You probably want to install
`rake` so that you can use the provided rake tasks.


## License

MIT - see the **COPYING** file.
