require 'elm_compiler'
require 'sprockets'
require 'tempfile'

class ElmSprockets < Sprockets::Processor
  def evaluate(context, locals)
    pathname = context.pathname.to_s

    if pathname =~ /\.js.*\.elm$/
      add_elm_dependencies pathname, context

      begin
        if defined?(Rails)
          output_file = "#{Rails.root}/tmp/cache/assets/elm.js"
          dir_options = {}
        else
          Tempfile.open "elm.js" do |file|
            output_file = file.path
            dir_options = chdir: Rails.root
          end
        end

        ElmCompiler.compile pathname, output_file, dir_options
      ensure
        File.delete output_file if File.exist? output_file
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

      unless match.nil?
        # e.g. Quiz.QuestionStore
        module_name = match.captures[0]

        # e.g. Quiz/QuestionStore
        dependency_logical_name = module_name.gsub(".", "/")

        # e.g. ~/NoRedInk/app/assets/javascripts/Quiz/QuestionStore.elm
        dependency_filepath = dirname + dependency_logical_name + ".elm"

        # If we don't find the dependency in our filesystem, assume it's because
        # it comes in through a third-party package rather than our sources.
        if File.file? dependency_filepath
          context.depend_on dependency_logical_name

          add_elm_dependencies dependency_filepath, context
        end
      end
    end
  end
end

if defined?(Rails)
  Rails.application.assets.register_engine('.elm', ElmCompiler)
end