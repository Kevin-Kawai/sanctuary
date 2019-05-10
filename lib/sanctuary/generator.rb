require "thor"
require_relative "reader"

module Sanctuary
  class Generator < Thor::Group
  include Thor::Actions
    argument :template

    def self.source_root
      Sanctuary::HOME_DIR
    end

    def create_lib_file
      # only copy the file and not the directory the file resides in
      copy_file "#{template}", "#{template.split("/").last}"
    end
  end
end
