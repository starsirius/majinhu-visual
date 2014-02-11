(($) ->
  'use strict'

  BlackInkGallery = (el) ->
    # constructor function

  BlackInkGallery.prototype.close = (e) ->
    # example function

  $.fn.blackInkGallery = () ->
    return @each () ->
      new BlackInkGallery(@)

  $.fn.blackInkGallery.Constructor = BlackInkGallery

) jQuery
