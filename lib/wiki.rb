require 'wikitext'

module Wiki

  def self.parser
    return @parser if @parser
    @parser = Wikitext::Parser.shared_parser
    @parser.internal_link_prefix = '/pages/'
    return @parser
  end

  def self.parse markup
    return parser.parse(markup)
  end

end
