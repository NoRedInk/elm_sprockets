require 'open3'

module ElmSprockets
  class Transformer
    class CompileError < StandardError; end

    def initialize(options = {})
      @options = options
    end

    def call(input)
      input_file = input[:filename]
      output_file = output_dir + input[:name] + '.js'

      cmd = "$(npm bin)/elm-make #{input_file} --output #{output_file} --yes"

      Open3.popen3(cmd, chdir: compile_dir) do |_in, _out, err, t|
        compiler_err = err.read

        raise(CompileError, compiler_err) if t.value != 0
      end

      { data: File.read(output_file) }
    end

    private

    def output_dir
      @options.fetch(:output_dir, './')
    end

    def compile_dir
      @options.fetch(:compile_dir, './')
    end
  end
end
