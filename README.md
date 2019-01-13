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


## Documentation

At the moment this parser is based on the kramdown parser, with the following changes:

* Support for fenced code blocks using three or more backticks has been added.
* Hard line breaks in paragraphs are enforced by default (see option `hard_wrap`).
* ATX headers need a whitespace character after the hash signs.
* Strikethroughs can be created using two tildes surrounding a piece of text
* Blank lines between paragraphs and other block elements are not needed by default (see option
  `gfm_quirks`)

Please note that the GFM parser tries to mimic the parser used at Github which means that for some
special cases broken behaviour is the expected behaviour.

Here is an example:

    This ~~is a complex strike through *test ~~with nesting~~ involved* here~~.

In this case the correct GFM result is:

    <p>This <del>is a complex strike through *test ~~with nesting</del> involved* here~~.</p>


### Options

The GFM parser provides the following options:

* `hard_wrap`: Interprets line breaks literally (default: `true`)

  Insert HTML `<br />` tags inside paragraphs where the original Markdown document had newlines (by
  default, Markdown ignores these newlines).

* `gfm_quirks`: Enables a set of GFM specific quirks (default: `paragraph_end`)

  The way how GFM is transformed on Github often differs from the way kramdown does things. Many of
  these differences are negligible but others are not.

  This option allows one to enable/disable certain GFM quirks, i.e. ways in which GFM parsing
  differs from kramdown parsing.

  The value has to be a list of quirk names that should be enabled, separated by commas. Possible
  names are:

  * `paragraph_end`

    Disables the kramdown restriction that at least one blank line has to be used after a paragraph
    before a new block element can be started.

    Note that if this quirk is used, lazy line wrapping does not fully work anymore!

  * `no_auto_typographic`

    Disables automatic conversion of some characters into their corresponding typographic symbols
    (like -- to em-dash etc). This helps to achieve results closer to what GitHub Flavored Markdown
    produces.


## Development

Clone the git repository and you are good to go. You probably want to install
`rake` so that you can use the provided rake tasks.


## License

MIT - see the **COPYING** file.
