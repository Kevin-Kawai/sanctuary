require "thor"
require_relative "reader"

module Sanctuary
  class Generator < Thor::Group
  include Thor::Actions
    argument :template
    argument :name
    argument :recipe

    def self.source_root
      Sanctuary::HOME_DIR
    end

    def create_lib_file
      unless recipe.empty?
        File.open(Sanctuary::HOME_DIR.gsub("templates", "recipes/") + template) do |file|
          file.each do |line|
            puts line
            copy_file "#{line.chomp}", "#{line.chomp.split("/").last}"
          end
        end
      else
        if name.empty?
          # only copy the file and not the directory the file resides in
          copy_file "#{template}", "#{template.split("/").last}"
        else
          copy_file "#{template}", "#{name + "." + template.split("/").last.split(".").last}"
          gsub_file "#{name + "." + template.split("/").last.split(".").last}", "#name", name
        end
      end
    end
  end
end
