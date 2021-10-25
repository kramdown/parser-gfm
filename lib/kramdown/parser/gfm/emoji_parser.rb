# -*- coding: utf-8; frozen_string_literal: true -*-
#
#--
# Copyright (C) 2019 Thomas Leitner <t_leitner@gmx.at>
#
# This file is part of kramdown-parser-gfm which is licensed under the MIT.
#++
#

require 'gemoji'

module Kramdown
  module Parser
    class GFM

      EMOJI_NAMES   = Emoji.all.flat_map(&:aliases).freeze
      REGISTRY      = EMOJI_NAMES.zip(EMOJI_NAMES).to_h.freeze
      EMOJI_PATTERN = /:(\w+):/

      # Based on the path rendered by `jemoji` plugin on GitHub Pages.
      DEFAULT_ASSET_PATH = 'https://github.githubassets.com/images/icons/emoji'

      private_constant :EMOJI_NAMES, :REGISTRY, :EMOJI_PATTERN,
                       :DEFAULT_ASSET_PATH

      define_parser(:emoji, EMOJI_PATTERN, ':')

      def parse_emoji
        start_line_number = @src.current_line_number
        result = @src.scan(EMOJI_PATTERN)
        name = @src.captures[0]

        return add_text(result) unless REGISTRY.key?(name)

        el = Element.new(:img, nil, nil, location: start_line_number)
        # Based on the attributes rendered by `jemoji` plugin on GitHub Pages.
        el.attr.update(
          'class'  => 'emoji',
          'title'  => result,
          'alt'    => result,
          'src'    => emoji_src(name),
          'height' => '20',
          'width'  => '20'
        )
        @tree.children << el
      end

      private

      def emoji_src(name)
        base = @options[:gfm_emoji_opts][:asset_path] || DEFAULT_ASSET_PATH
        File.join(base, Emoji.find_by_alias(name).image_filename)
      end

    end
  end
end
