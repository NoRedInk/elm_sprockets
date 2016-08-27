module ElmSprockets
  class Railtie < Rails::Railtie
    config.assets.configure do |env|
      env.register_mime_type 'text/x-elm', extensions: ['.elm']
      env.register_preprocessor 'text/x-elm', Sprockets::DirectiveProcessor.new(comments: ["--", ["{-", "-}"]])

      output_dir = Rails.root.join("tmp", "cache", "assets", "elm")
      transformer = Transformer.new(output_dir: output_dir, compile_dir: Rails.root)
      env.register_transformer 'text/x-elm', 'application/javascript', transformer
    end
  end
end
