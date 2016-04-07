require_relative '../lib/elm_sprockets/compiler'
require 'tempfile'
require 'minitest/autorun'

class ElmCompilerTest < Minitest::Test
  def test_compile
    dirname = File.dirname(__FILE__)

    Tempfile.create(["elm",".js"]) do |file|
      puts file.path
      ElmSprockets::Compiler.compile "#{dirname}/elm/MainTest.js.elm", file
      assert_match(/Elm/, file.read)
    end
  end
end
