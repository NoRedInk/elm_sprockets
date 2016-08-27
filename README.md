# ElmSprockets - Elm inside Rails

## Usage

In your Gemfile:

``` ruby
gem 'elm_sprockets', '~> 0.2.0'
```

Now Elm modules can be normally required inside Sprockets manifest files:

``` js
//= require jquery
//= require jquery_ujs
//= require ElmModule
//= require_tree .
```
### Dependencies

If you have Elm module, which imports other Elm modules you need to tell Sprockets to watch for their changes also. This is done through standard Sprockets comment directives on first lines of dependent module:

```
--= depend_on MyOtherModule
module Main exposing (..)

import Html exposing (..)
import MyOtherModule exposing (..)

main =
  div [] [text "Hello World!"]
```
If you don't do that your Main module will be recompiled only when changes are done directly in him.

For other Sprockets directives see https://github.com/rails/sprockets/blob/master/guides/end_user_asset_generation.md
