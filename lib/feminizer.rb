require 'nokogiri'

module Feminizer

  VERSION = "1.0.7"


  extend self

  def forms=(hash)
    @forms = hash
  end

  def forms
    @forms || default_forms
  end

  def feminize_html content
    tree = Nokogiri::HTML content
    feminize_node! tree
    tree.to_html
  end

  def feminize_text string
    return string if ['', '\n', "\n"].include?(string.to_s)

    string = string.dup
    #string = string.gsub(/\302\240/, ' ')

    forms.each do |masculine, feminine|
      if string =~ /#{feminine}/i
        string = string_search_replace(string, feminine, masculine, :mark)    unless 'his' == masculine
        string = string_search_replace(string, masculine, feminine)
        string = string_search_replace(string, feminine, masculine, :unmark)  unless 'his' == masculine
      elsif string =~ /#{masculine}/i
        string = string_search_replace(string, masculine, feminine)
      end
    end

    string
  end

  protected

    def feminize_node! node, indent = 0
      case node.name
      when 'text'
        # print " "*indent
        # puts "feminizing: #{node.content.inspect}"
        node.content = feminize_text(node.content)
        # print " "*indent
        # puts "out: #{node.content.inspect}"
      when 'a'
        # puts "rewriting: #{node.attributes['href'].value}"
        if href = node.attributes['href']
          href.value = href.value.sub(/https?:\/\/artofmanliness.com\/?/, '/')
        end
      else
        # puts 'not processing: '+node.inspect
      end

      if node.children.size > 0
        node.children.each do |child|
        # print " "*indent
        # puts "-> #{child.name}"
          feminize_node! child, indent + 1
        end
      end
    end


    def ok
     @ok ||= %Q{([\s"'’:;\.,\>\<\?\!\{\}\(\)-])}
    end

    def string_search_replace(string, from, to, mode = nil)
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
