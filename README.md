# kramdown GFM parser

This is a parser for [kramdown](https://kramdown.gettalong.org) that converts Markdown documents
in the [GitHub Flavored Markdown (GFM)](https://github.github.com/gfm/) dialect to HTML.

Note: Until kramdown version 2.0.0 this parser was part of the kramdown distribution.


## Installation

```bash
gem install kramdown-parser-gfm
```


## Usage

```ruby
require 'kramdown'
require 'kramdown-parser-gfm'

Kramdown::Document.new(text, input: 'GFM').to_html
```


## Documentation

At the moment this parser is based on the kramdown parser, with the following changes:

* Support for fenced code blocks using three or more backticks has been added.
* Hard line breaks in paragraphs are enforced by default (see option `hard_wrap`).
* ATX headers need a whitespace character after the hash signs.
* Strikethroughs can be created using two tildes surrounding a piece of text.
* Blank lines between paragraphs and other block elements are not needed by default (see option
  `gfm_quirks`).
* Render emojis used at GitHub .

Please note that the GFM parser tries to mimic the parser used at GitHub which means that for some
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

  The way how GFM is transformed on GitHub often differs from the way kramdown does things. Many of
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

* `gfm_emojis`: Enables rendering emoji amidst GFM (default: `false`)

  Usage requires `gem "gemoji", "~> 3.0"` that will have to be installed and managed separately
  either directly or via your Gemfile.

* `gfm_emoji_opts`: Configuration for rendering emoji amidst GFM (default: `{}`)

  The value has to be mapping of key-value pairs.

  Valid option(s):

  * `asset_path`

    The remote location of emoji assets that will be prefixed to emoji file path. Gemoji 3 has
    the file path set to `unicode/[emoji-filename]`.

    Defaults to `https://github.githubassets.com/images/icons/emoji`.

    Therefore the absolute path to an emoji file would be:
    `https://github.githubassets.com/images/icons/emoji/unicode/[emoji-filename]`


## Development

Clone the git repository and you are good to go. You'll probably want to install `rake` to use the
provided rake tasks.

Run `rake --tasks` to view a list of available tasks.


## License

MIT - see the [**COPYING**](COPYING) file.
