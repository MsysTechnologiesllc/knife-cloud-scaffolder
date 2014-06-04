#!/usr/bin/env ruby

# list all erb files in folder
# process erb file and write out in same structure, renaming to remove erb
# list all folders and rename any cloud tags.

require 'json'
require 'fileutils'
require './erb_helpers'

def mylog(string)
  unless ENV["enabledebug"].nil?
    puts string
  end
end

class Codegenerator

  def initialize(destination_dir, properties_file)
    @destination_dir = destination_dir
    @properties_file = properties_file
  end

  private
  def _properties
    @properties ||= JSON.parse(File.read(@properties_file))
  end

  def _src_files
    Dir.glob(File.join("templates", "**", "*"))
  end

  def _erbfiles
    Dir.glob(File.join("templates", "**", "*.erb"))
  end

  # return all folders within source templates
  def _folders
    Dir.glob(File.join("templates", "**/"))
  end

  def cloudname
    _properties["__MY_CLOUD_NAME__"]
  end

  def _create_folders_in_destination
    _folders.each do |folder|
      mylog "Processing folder [#{folder}]..."
      destination = folder.sub(/__MY_CLOUD_NAME__/, cloudname).sub(/templates?/, @destination_dir)
      mylog "Creating directory (#{destination})..."
      begin
        Dir.mkdir(destination)
      rescue Errno::EEXIST
      end
    end
  end

  def _generate_static_files
    (_src_files - _erbfiles).each do |file|
      unless File.directory?(file)
        mylog "Copying static file [#{file}] to [#{file.sub(/templates?/, @destination_dir)}]"
        ::FileUtils.cp(file, file.sub(/templates?/, @destination_dir))
      end
    end
  end

  def _generate_source_files
    _erbfiles.each do |erb_file|
      mylog "Processing file [#{erb_file}]..."
      # Compile the erb
      content = ERBHelpers::ERBCompiler.run(File.read(erb_file), _properties)

      destination_file_name = File.join(@destination_dir, erb_file.sub(/templates?/, '').sub(/.erb$/, '')).sub(/__MY_CLOUD_NAME__/, cloudname)
      mylog "Writing to a file (#{destination_file_name})..."
      File.open(destination_file_name, "w") do |f|
        f.write(content)
      end
    end
  end

  public
  def run
    _create_folders_in_destination

    _generate_static_files

    _generate_source_files
  end

end


## Main
destination_dir, properties_file = ARGV[0], ARGV[1]

# create destination if required.
Dir.mkdir(destination_dir) unless File.directory?(destination_dir)

Codegenerator.new(destination_dir, properties_file).run
