module Shag
  class Generator
    attr_reader :app_name

    def initialize(name)
      @app_name = name
      @app_dir  = File.join(Dir.pwd, name)
    end

    def run
      puts "Creating directory"
      Dir.mkdir(@app_dir)
      Dir.chdir(@app_dir)
      generate_gemfile
      generate_procfile
      generate_sinatra_file
      bundle
      git_init
      puts "Project #{@app_name} has been created"
    end

    private
    def generate_gemfile
      puts "Writing Gemfile"
      File.open('Gemfile', 'w') { |f| f.write(gemfile_content) }
    end

    def generate_procfile
      puts "Writing Procfile"
      File.open('Procfile', 'w') { |f| f.write(procfile_content) }
    end

    def generate_sinatra_file
      puts "Writing #{@app_name}.rb"
      File.open("#{@app_name}.rb", 'w') { |f| f.write(sinatra_file_content) }
    end

    def bundle
      puts 'Running bundle install'
      puts `bundle install`
    end

    def git_init
      puts 'Initializing git repo'
      puts `git init`
    end

    def gemfile_content
      <<-GEMFILE
source :rubygems

gem 'sinatra'
      GEMFILE
    end

    def procfile_content
      <<-PROCFILE
web: bundle exec ruby #{@app_name}.rb -p $PORT
      PROCFILE
    end

    def sinatra_file_content
      <<-SINATRA_FILE
require 'sinatra'

get '/' do
  puts "Hello world!"
end
      SINATRA_FILE
    end
  end
end