module ElmSprockets
  class Engine < ::Rails::Engine
    isolate_namespace ElmSprockets
    initializer "elm_sprockets.assets.register", group: all do |app|
      app.assets.register_engine('.elm', ElmSprockets::SprocketsEngine)
      app.assets.register_mime_type('text/x-elm', '.elm')

      app.config.assets.precompile.delete_if do |rule|
        next unless rule.is_a? Proc
        # delete the rule that doesn't match cs or js but matches elm
        ['css', 'js'].none? {|ext| rule.call "butts.#{ext}"} && rule.call('butts.elm')
      end
      app.config.assets.precompile << Proc.new{ |path| !File.extname(path).in?(['.js', '.css', '.elm']) }
    end
  end
end
