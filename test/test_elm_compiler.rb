require 'test/unit'
require 'elm_compiler'
require 'tempfile'

class ElmCompilerTest < Test::Unit::TestCase
  def test_compile
    dirname = File.dirname(__FILE__)

    Tempfile.open "elm.js" do |file|
      output_file = file.path
      ElmCompiler.compile "#{dirname}/elm/MainTest.js.elm", output_file
    end
  end
end
