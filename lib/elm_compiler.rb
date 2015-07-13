require 'open3'

class ElmCompiler
  def self.compile(pathname, output_file, dir_options = {})
    # TODO pull this out into its own gem, so we can remove the node dependency.
    cmd = `node -e "process.stdout.write(require('elm')['elm-make']);"`

    # need to specify LANG or else build will fail on jenkins
    # with error "elm-make: elm-stuff/build-artifacts/NoRedInk/NoRedInk/1.0.0/Quiz-QuestionStore.elmo: hGetContents: invalid argument (invalid byte sequence)"
    Open3.popen3({'LANG' => 'en_US.UTF-8'}, cmd, pathname.to_s, "--yes", "--output", output_file, dir_options) do |_stdin, stdout, stderr, wait_thr|
      compiler_output = stdout.gets(nil)
      stdout.close

      compiler_err = stderr.gets(nil)
      stderr.close

      process_status = wait_thr.value

      if process_status.exitstatus != 0
        raise compiler_err
      end
    end

    File.read output_file
  end
end
