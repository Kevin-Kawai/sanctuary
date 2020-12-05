require "tty-prompt"
require_relative "generator"
require_relative "reader"

module Sanctuary
  class CLI
    def self.start
      if ARGV.include?("-m")
        results = multi_select
        results.each do |result|
          Generator.start([result[1..-1], '', ''])
        end
      elsif ARGV.include?("--recipe")
        result = present_recipe_choices
        Generator.start([result[1..-1], '', 'recipe'])
      elsif ARGV.include?("--script")
        result = present_script_choices
        Generator.start([result[1..-1], '', 'script'])
      else
        result = present_choices
        if ARGV.include?("-p")
          Generator.start([result[1..-1], ARGV.last, ''])
        elsif ARGV.include?("--file")
          Generator.start([result[1..-1], '', ''])
        end
      end
    end

    private

    def self.present_choices(path = "") 
      choices = Reader.read_templates(path)[2..-1].sort
      prompt = TTY::Prompt.new
      prompt_choice = prompt.enum_select("Select a template?", choices)
      if Reader.directory?(path.empty? ? prompt_choice : path + "/" + prompt_choice)
        return present_choices(path + "/" + prompt_choice)
      end
      return path + "/" + prompt_choice
    end

    def self.present_recipe_choices(path = "")
      choices = Reader.read_recipes(path)[2..-1].sort
      prompt = TTY::Prompt.new
      prompt_choice = prompt.enum_select("Select a template?", choices)
      if Reader.directory?(path.empty? ? prompt_choice : path + "/" + prompt_choice)
        return present_recipe_choices(path + "/" + prompt_choice)
      end
      return path + "/" + prompt_choice
    end

    def self.present_script_choices(path = "")
      choices = Reader.read_scripts(path)[2..-1].sort
      prompt = TTY::Prompt.new
      prompt_choice = prompt.enum_select("Select a template?", choices)
      if Reader.directory?(path.empty? ? prompt_choice : path + "/" + prompt_choice)
        return present_recipe_choices(path + "/" + prompt_choice)
      end
      return path + "/" + prompt_choice
    end

    def self.multi_select(path = "")
      choices = Reader.read_templates(path)[2..-1].sort
      prompt = TTY::Prompt.new
      prompt_choices = prompt.multi_select("Select a templates", choices)
      if Reader.directory?(prompt_choices[0])
        return multi_select(path + "/" + prompt_choices[0])
      end

      prompt_choices.map do |choice|
        path + "/" + choice
      end
    end
  end
end
