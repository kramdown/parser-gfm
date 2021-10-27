# -*- coding: utf-8; frozen_string_literal: true -*-
#
#--
# Copyright (C) 2019 Thomas Leitner <t_leitner@gmx.at>
#
# This file is part of kramdown-parser-gfm which is licensed under the MIT.
#++
#

module Kramdown
  module Options

    define(:hard_wrap, Boolean, true, <<~EOF)
      Interprets line breaks literally

      Insert HTML `<br />` tags inside paragraphs where the original Markdown
      document had newlines (by default, Markdown ignores these newlines).

      Default: true
      Used by: GFM parser
    EOF

    define(:gfm_quirks, Object, [:paragraph_end], <<~EOF) do |val|
      Enables a set of GFM specific quirks

      The way how GFM is transformed on Github often differs from the way
      kramdown does things. Many of these differences are negligible but
      others are not.

      This option allows one to enable/disable certain GFM quirks, i.e. ways
      in which GFM parsing differs from kramdown parsing.

      The value has to be a list of quirk names that should be enabled,
      separated by commas. Possible names are:

      * paragraph_end

        Disables the kramdown restriction that at least one blank line has to
        be used after a paragraph before a new block element can be started.

        Note that if this quirk is used, lazy line wrapping does not fully
        work anymore!

      * no_auto_typographic

        Disables automatic conversion of some characters into their
        corresponding typographic symbols (like `--` to em-dash etc).
        This helps to achieve results closer to what GitHub Flavored
        Markdown produces.

      Default: paragraph_end
      Used by: GFM parser
    EOF
      simple_array_validator(val, :gfm_quirks).map! do |v|
        v.kind_of?(Symbol) ? v : str_to_sym(v.to_s)
      end
    end

    define(:gfm_emojis, Boolean, false, <<~EOF)
      Enable rendering emoji amidst GitHub Flavored Markdown.

      NOTE: This feature depends on additional gem(s) that will have to be
      installed and managed separately.

      Dependencies:
        gem 'gemoji', '~> 3.0'

      Default: false
      Used by: GFM parser
    EOF

    define(:gfm_emoji_opts, Object, {}, <<~EOF) do |val|
      Set options for rendering emoji amidst GitHub Flavored Markdown.

      The value needs to be a hash with key-value pair(s).

      Available key(s):

        * asset_path:

          The remote location of emoji assets that will be prefixed to emoji
          file path. Gemoji 3 has the file path set to 'unicode/[emoji-filename]'.

          Defaults to 'https://github.githubassets.com/images/icons/emoji'.

          Therefore the absolute path to an emoji file would be:
          'https://github.githubassets.com/images/icons/emoji/unicode/[emoji-filename]'

      Default: {}
      Used by: GFM parser
    EOF
      val = simple_hash_validator(val, :gfm_emoji_opts)
      val.keys.each do |k|
        val[k.kind_of?(String) ? str_to_sym(k) : k] = val.delete(k)
      end
      val
    end

  end
end
