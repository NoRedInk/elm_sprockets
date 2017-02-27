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

      cmd = "elm make #{input_file} --output #{output_file} --yes"

      Open3.popen3(cmd, chdir: compile_dir) do |_in, out, err, t|
        compiler_out = out.read
        compiler_err = err.read
        if t.value != 0
          raise CompileError, compiler_err
        end
      end

      { data: File.read(output_file) }
    end

    private

    def output_dir
      @options.fetch(:output_dir, "./")
    end

    def compile_dir
      @options.fetch(:compile_dir, './')
    end
  end
end
