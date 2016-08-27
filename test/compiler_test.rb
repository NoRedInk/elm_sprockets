require_relative '../lib/elm_sprockets/transformer'
require 'tempfile'
require 'minitest/autorun'

class ElmCompilerTest < Minitest::Test
  def test_compile
    dirname = File.dirname(__FILE__)

    transformer = ElmSprockets::Transformer.new
    compiled = transformer.call(filename: "#{dirname}/elm/MainTest.js.elm", name: 'MainTest')

    assert_match(/Elm/, compiled[:data])
  end
end
