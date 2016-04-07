require 'elm_sprockets/compiler'
require 'sprockets'
require 'tempfile'

module ElmSprockets
  class Processor < Sprockets::Processor
    def self.default_mime_type
      'text/x-elm'
    end

    def evaluate(context, _locals)
      pathname = context.pathname.to_s

      if pathname =~ /\.js.*\.elm$/
        add_elm_dependencies pathname, context
        tempfile = Tempfile.new ['compiled_elm_output', '.js']
        begin
          ElmSprockets::Compiler.compile pathname, tempfile, chdir: Rails.root
          tempfile.read
        ensure
          tempfile.close
        end
      else
        ""
      end
    end

    private

    # Add all Elm modules imported in the target file as dependencies, then
    # recursively do the same for each of those dependent modules.
    def add_elm_dependencies(filepath, context)
      # Turn e.g. ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStoreAPI.js.elm
      # into just ~/NoRedInk/app/assets/javascripts/
      dirname = context.pathname.to_s.gsub Regexp.new(context.logical_path + ".+$"), ""

      File.read(filepath).each_line do |line|
        # e.g. `import Quiz.QuestionStore exposing (..)`
        match = line.match(/^import\s+([^\s]+)/)

        next unless match

        # e.g. Quiz.QuestionStore
        module_name = match.captures[0]

        # e.g. Quiz/QuestionStore
        dependency_logical_name = module_name.tr(".", "/")

        # e.g. ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStore.elm
        dependency_filepath = dirname + dependency_logical_name + ".elm"

        # If we don't find the dependency in our filesystem, assume it's because
        # it comes in through a third-party package rather than our sources.
        next unless File.file? dependency_filepath

        context.depend_on dependency_logical_name
        add_elm_dependencies dependency_filepath, context
      end
    end
  end
end
