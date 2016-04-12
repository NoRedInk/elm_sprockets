require "elm_sprockets/processor"

module ElmSprockets
  def self.initialize(app)
    app.assets.register_engine('.elm', ElmSprockets::Processor)
    app.assets.register_mime_type('text/x-elm', '.elm')

    dont_pass_through_elm_files_hack(app.config.assets.precompile)
  end


  # by default, Rails in 3.2 in will pass through non js & css files
  # before: when precompiling assets, elm files were included as raw elm
  # in the output
  # after this hack: raw elm files aren't passed through
  # coffee script and sass plugins handle this differently but we didn't
  # get around to doing this properly. I'd call this a hack.
  private_class_method \
  def self.dont_pass_through_elm_files_hack(precompile_rules)
    # there's a rule that says, "if it matches CSS or JS, lets preprocess and not
    # pass thorugh, otherwise, lets just pass through. This removes that rule.
    # e.g. we want to find the rule that doesn't match CSS or JS but does
    # match elm files and kill it
    precompile_rules.delete_if do |rule|
      next unless rule.is_a? Proc
      ['css', 'js'].none? {|ext| rule.call "test.#{ext}"} &&
        rule.call('test.elm')
    end

    # here we replace it with a rule that also ignores elm files so we can
    # preprocess them ourselves
    precompile_rules <<
      Proc.new{ |path| !File.extname(path).in?(['.js', '.css', '.elm']) }
  end
end
