require 'spec_helper'

describe "Generator" do
  include FakeFS::SpecHelpers

  before do
    @gen = Shag::Generator.new("test_app")
    @app_name = "test_app"
  end

  describe "private methods" do

    describe "#bundle" do
      it "runs bundle install" do
        stub_shell do
          command "bundle install" do
            stdout <<-HERE
Using thor (0.16.0) 
Using shag (0.0.1) 
Using bundler (1.2.3) 
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
            HERE
          end
        end

        output = capture_stdout { @gen.send(:bundle) }
        output.should eq <<-HERE
Running bundle install
Using thor (0.16.0) 
Using shag (0.0.1) 
Using bundler (1.2.3) 
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
        HERE
      end
    end

    describe "#git_init" do
      it "runs git init" do
        stub_shell do
          command "git init" do
            stdout <<-HERE
Initialized empty Git repository in /#{@app_name}/.git/
            HERE
          end
        end

        output = capture_stdout { @gen.send(:git_init) }
        output.should eq <<-HERE
Initializing git repo
Initialized empty Git repository in /#{@test_app}/.git/
        HERE
      end
    end

    describe "#generate_gemfile" do
      before { @output = capture_stdout { @gen.send(:generate_gemfile) } }

      it "creates a Gemfile" do
        File.exists?("Gemfile")
      end

      it "prints status to STDOUT" do
        @output.should eq "Writing Gemfile\n"
      end

      it "generates a Gemfile with the correct content" do
        contents = File.read("Gemfile")
        contents.should eq <<-CONTENTS
source :rubygems

gem 'sinatra'
        CONTENTS
      end
    end

    describe "#generate_procfile" do
      before { @output = capture_stdout { @gen.send(:generate_procfile) } }

      it "creates a Procfile" do
        File.exists?("Procfile")
      end

      it "prints status to STDOUT" do
        @output.should eq "Writing Procfile\n"
      end

      it "generates a Procfile with the correct content" do
        contents = File.read("Procfile")
        contents.should eq <<-CONTENTS
web: bundle exec ruby #{@app_name}.rb -p $PORT
        CONTENTS
      end
    end

    describe "#generate_sinatra_file" do
      before { @output = capture_stdout { @gen.send(:generate_sinatra_file) } }

      it "creates a .rb file named after the @app_name" do
        File.exists?("#{@app_name}.rb")
      end

      it "prints status to STDOUT" do
        @output.should eq "Writing #{@app_name}.rb\n"
      end

      it "generates a Sinatra application file with the correct content" do
        contents = File.read("#{@app_name}.rb")
        contents.should eq <<-CONTENTS
require 'sinatra'

get '/' do
  puts "Hello world!"
end
        CONTENTS
      end
    end
  end
end