require "tty-prompt"
require_relative "generator"
require_relative "reader"

module Sanctuary
  class CLI
    def self.start
      choices = Reader.read_templates[2..-1]
      prompt = TTY::Prompt.new
      result = prompt.enum_select("Select a template?", choices)
      Generator.start([result])
    end
  end
end
