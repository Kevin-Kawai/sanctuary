require "tty-prompt"
require_relative "generator"
require_relative "reader"

module Sanctuary
  class CLI
    def self.start
      result = present_choices
      if ARGV.include?("-p")
        Generator.start([result[1..-1], ARGV.last])
      else
        Generator.start([result[1..-1]])
      end
    end

    private

    def self.present_choices(path = "") 
      choices = Reader.read_templates(path)[2..-1].sort
      prompt = TTY::Prompt.new
      prompt_choice = prompt.enum_select("Select a template?", choices)
      if Reader.directory?(prompt_choice)
        return present_choices(path + "/" + prompt_choice)
      end
      return path + "/" + prompt_choice
    end
  end
end
