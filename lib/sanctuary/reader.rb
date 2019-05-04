module Sanctuary
  HOME_DIR = Dir.home + "/.sanctuary/templates"
  class Reader
    def self.read_templates
      Dir.open(HOME_DIR).to_a
    end
  end
end
