require_relative("reader")

module Sanctuary
  class RecipeGenerator
    def self.generate_recipe
      current_dir_path = Dir.pwd
      raise "Recipe Already Exists" if Dir.exists?(Sanctuary::HOME_DIR + "/starters/#{current_dir_path.split("/").last}_starter") 

      FileUtils.copy_entry(current_dir_path, Sanctuary::HOME_DIR + "/starters/#{current_dir_path.split("/").last}_starter")
      current_files = Dir.entries(".")[2..Dir.entries(".").length]
      File.open(Sanctuary::HOME_DIR.gsub("templates", "recipes") + "/" + current_dir_path.split("/").last + "_recipe", "w") do |file|
        Dir.glob("**/*").each do |entry|
          unless File.directory?(entry)
            file.write("starters/#{current_dir_path.split("/").last}_starter||" + entry + "\n")
          end
        end
      end
    end
  end
end
