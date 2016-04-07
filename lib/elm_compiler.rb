require 'open3'

class ElmCompiler < Sprockets::Processor
  def self.compile(pathname, output_file, dir_options = {})
    @cmd ||= "#{`npm bin`.strip}/elm-make"

    # need to specify LANG or else build will fail on jenkins
    # with error "elm-make: elm-stuff/build-artifacts/NoRedInk/NoRedInk/1.0.0/Quiz-QuestionStore.elmo: hGetContents: invalid argument (invalid byte sequence)"
    Open3.popen3(
        {'LANG' => 'en_US.UTF-8'},
        @cmd, pathname.to_s,
        "--yes", "--output",
        output_file.path, dir_options) do |_stdin, _stdout, stderr, wait_thr|
      compiler_err = stderr.gets(nil)
      stderr.close

      process_status = wait_thr.value

      if process_status.exitstatus != 0
        fail compiler_err
      end
    end
  end
end
