This works with Rails 3.2

This requires some piping together with npm & elm-make that we haven't quite figured out
process-with. At the very least, you're going to need to:

- copy the `package.json` from this repo in to your rails repo and call `npm install`
- create an initializer in `config/initializers/elm_sprockets.rb` with the following contents:

```ruby
ElmSprockets.initialize(Rails.application)
```

At some point we'll figure out generators, etc. For now: This is it!
