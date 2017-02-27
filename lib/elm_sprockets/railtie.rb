module ElmSprockets
  class Railtie < Rails::Railtie
    MIME_TYPE = 'text/x-elm'.freeze
    config.assets.configure do |env|
      env.register_mime_type MIME_TYPE, extensions: ['.elm']
      env.register_preprocessor MIME_TYPE, Sprockets::DirectiveProcessor.new(comments: ["--", ["{-", "-}"]])

      output_dir = Rails.root.join('tmp', 'cache', 'assets', 'elm')
      transformer =
        Transformer.new(output_dir: output_dir, compile_dir: Rails.root)
      env.register_transformer(MIME_TYPE, 'application/javascript', transformer)
    end
  end
end
