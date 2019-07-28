module Sanctuary
  HOME_DIR = Dir.home + "/.sanctuary/templates"
  class Reader
    def self.read_templates(path = "")
      Dir.open(HOME_DIR + "/#{path}").to_a
    end

    def self.read_recipes(path = "")
      Dir.open(HOME_DIR.gsub("templates", "recipes") + "/#{path}").to_a
    end

    def self.directory?(path = "")
      Pathname.new(HOME_DIR + "/#{path}").directory?
    end
  end
end
