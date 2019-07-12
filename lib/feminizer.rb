require 'nokogiri'

module Feminizer

  VERSION = "1.0.7"

  extend self

  def forms=(hash)
    @forms = hash
    @form_trie = nil
  end

  def forms
    @forms || default_forms
  end

  def form_trie
    @form_trie ||= construct_form_trie
  end

  def feminize_html content
    tree = Nokogiri::HTML content
    feminize_node! tree
    tree.to_html
  end

  def feminize_text string
    # early return if blank
    return string if string.to_s =~ /^\s*$/

    Replacer.new(string.dup, form_trie).result
  end

  private

  # Create a trie that lets us can iterate through a string by character and
  # build up possible values to swap
  def construct_form_trie
    trie = {}
    forms.each do |first, second|
      trie = construct_trie(trie, first, second)
      trie = construct_trie(trie, second, first)
    end
    trie
  end

  def construct_trie(subtrie, search, replace)
    if search.empty?
      subtrie[:terminal] = replace
    else
      next_char = search[0]
      subtrie[next_char] = construct_trie(subtrie[next_char] || {}, search[1..-1], replace)
    end
    subtrie
  end

  def feminize_node! node, indent = 0
    case node.name
    when 'text'
      node.content = feminize_text(node.content)
    when 'a'
      if href = node.attributes['href']
        href.value = href.value.sub(/https?:\/\/artofmanliness.com\/?/, '/')
      end
    end

    if node.children.size > 0
      node.children.each do |child|
        feminize_node! child, indent + 1
      end
    end
  end

  # Create an index of substrings that have been converted (index, length)
  # For each form pair
  #   Scan the string for each term adjacent to a word boundary
  #   Skip over any sections that have already been converted.
  #   Perform a case-insensitive search. Before swapping, determine if the found term is in:
  #     * lowercase
  #     * UPPERCASE
  #     * Titlecase
  #   If the casing is something else, assume Titlecase
  #   Convert the replacement term to the correct casing.
  #   Swap the term with it's replacement, updating the manifest to mark this part of the string
  class Replacer
    TERM_BOUNDARIES = /[\s"'’:;\.,\>\<\?\!\{\}\(\)-]/

    def initialize(string, form_trie)
      @string = string
      @form_trie = form_trie
    end

    def result
      @string
    end
  end

  def old_string_search_replace(string, from, to, mode = nil)
    [
      [ from, to],
      [ from[0..0].upcase  + from[1..-1],
        to[0..0].upcase + to[1..-1] ]
    ].each do |search, replace|
      case mode
      when :mark
        replace = "[marked]#{search}[marked]"
      when :unmark
        search = /\[marked\]#{search}\[marked\]/
      end
      require 'pry'
      binding.pry if string.include?('(Man')

      string.gsub! %r{#{ok}#{search}#{ok}},  '\1'+replace+'\2'
      string.gsub! %r{^#{search}#{ok}},      replace+'\1'
      string.gsub! %r{#{ok}#{search}$},      '\1'+replace
      string.gsub! %r{^#{search}$},          replace

    end
    string
  end

  def default_forms
    {
      'man' =>         'woman',
      'men' =>         'women',
      'manly' =>       'womanly',
      'manliness' =>   'womanliness',
      'manlier' =>     'womanlier',
      'manliest' =>    'womanliest',
      'manhood' =>     'womanhood',
      'manvotional' => 'womanvotional',
      'masculine' =>   'feminine',
      'masculinity' => 'femininity',
      'male' =>        'female',
      'patriarch' =>   'matriarch',
      'feminist' =>    'chauvanist',
      'actress' =>     'actor',
      'feminists' =>   'chauvanists',
      'mr.' =>         'ms.',
      'boy' =>         'girl',
      'boys' =>        'girls',
      'guy' =>         'gal',
      'guys' =>        'gals',
      'dude' =>        'lady',
      'dudes' =>       'ladies',
      'he' =>          'she',
      'him' =>         'her',
      'his' =>         'her',
      'himself' =>     'herself',
      'waitress' =>    'waiter',
      'waitressed' =>  'waited',
      'craftsman' =>   'craftswoman',
      'nobleman' =>    'noblewoman',
      'gentleman' =>   'lady',
      'gentlemen' =>   'ladies',
      'prince' =>      'princess',
      'princes' =>     'princesses',
      'king' =>        'queen',
      'kings' =>       'queens',
      'sissy' =>       'boyish',
      'emasculate' =>  'defeminize',
      'cowboy' =>      'cowgirl',
      'cowboying' =>   'cowgirling',
      'cowboys' =>     'cowgirls',
      'dad' =>         'mom',
      'daddy' =>       'mommy',
      'dick' =>        'pussy',
      'ex-wife' =>     'ex-husband',
      'father' =>      'mother',
      'fathers' =>     'mothers',
      'brother' =>     'sister',
      'brothers' =>    'sisters',
      'Matt' =>        'Mattie',
      'David' =>       'Davida',
      'Paul' =>        'Paula'
    }
  end

end
