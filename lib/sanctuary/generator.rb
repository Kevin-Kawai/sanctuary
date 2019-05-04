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
      copy_file "#{template}", "#{template}"
    end
  end
end
