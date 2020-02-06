# frozen_string_literal: true

require 'linode/ip/version'
require 'json'

module Linode
  # Method for fetching ip of linode matching a label.
  module Ip
    class Error < StandardError; end

    def fetch(name)
      matched_linodes = maching_linodes(linodes, name)

      return if matched_linodes.empty?

      return matched_linodes[0]['ipv4'].first if matched_linodes.count == 1

      n = select_linodes_index(matched_linodes)

      if n == 'u'
        fetch(read_matcher)
      else
        matched_linodes[n]['ipv4'].first
      end
    end

    private

    def linodes
      @linodes ||= JSON.parse(`linode-cli --json linodes list`)
    end

    def select_linodes_index(linodes)
      puts_which_linodes(linodes)
      process_linodes_selection(linodes, STDIN.gets.chomp)
    end

    def read_matcher
      puts 'What matcher should I use?'
      STDIN.gets.chomp
    end

    def maching_linodes(linodes, name)
      linodes
        .select { |linode| linode['label'].match?(/#{name}/) }
    end

    def puts_which_linodes(linodes)
      puts 'Multiple matching linodes found:'
      puts '-------------------------------'
      linodes.each_with_index do |linode, n|
        puts "(#{n}) #{linode['label']}"
      end

      puts
      puts '[u] Update linode matcher'
      puts '[e] exit'
      puts
      puts 'Choose a lionde or command?'
    end

    def process_linodes_selection(linodes, selection)
      if (0...linodes.count).map(&:to_s).include?(selection)
        selection.to_i
      elsif selection == 'e'
        puts_good_bye
      elsif selection == 'u'
        selection
      else
        select_linodes_index(linodes)
      end
    end

    def puts_good_bye
      puts 'Good bye!'
      exit
    end
  end
end
