require "thor"
require_relative "reader"

module Sanctuary
  class Generator < Thor::Group
  include Thor::Actions
    argument :template
    argument :name
    argument :type

    def self.source_root
      Sanctuary::HOME_DIR
    end

    def create_lib_file
      if type == 'recipe'
        File.open(Sanctuary::HOME_DIR.gsub("templates", "recipes/") + template) do |file|
          file.each do |line|
            copy_file "#{line.gsub("||", "/").chomp}", "#{line.split("||")[1..-1].join("/").chomp}"
          end
        end
        if Dir.entries(".").include?('sanctuary-post-recipe-copy-hook.sh')
          system "sh ./sanctuary-post-recipe-copy-hook.sh"
        end
      elsif type == 'script'
        if name.nil?
          system "sh #{Sanctuary::HOME_DIR.gsub("templates", "scripts/")}#{template}"
        else
          system "sh #{Sanctuary::HOME_DIR.gsub("templates", "scripts/")}#{template} #{name}"
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
