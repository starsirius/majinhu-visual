(($) ->
  'use strict'

  BlackInkGallery = (el) ->
    # constructor function
    
    # defaults
    minHeight = 500
    hwRatioThreshold = 1.5
    
    # set up container
    windowHeight = $(window).height()
    $(el).addClass("black-ink-gallery").height windowHeight + "px"
    $(el).wrapInner '<div class="big-inner"></div>'

    numberOfImages = ($figures = $(el).find "figure").length
    numberOfImagesLoaded = 0

    # set up each image's width and height
    $figures.each (index) ->
      $image = $(@).find("img").first()

      # Webkit browsers set the height and width property 
      # after the image is loaded. Create a memory copy of 
      # each image and set its w and h on loading.
      $(new Image()).load( () ->
        $image.data "width", @width
        $image.data "height", @height
        processImages() if ++numberOfImagesLoaded is numberOfImages
      ).attr("src", $image.attr("src"))

    processImages = () ->

      figureGroup = [] # a figureGroup will occupy a figure column
      bigColumn = '<div class="big-figure-column"></div>'

      $figures.each (index) ->
        #$(@).find("figurecaption").addClass "big-figurecaption"

        $image = $(@).find("img").first()
        w = $image.data "width"; h = $image.data "height"

        #$(@).addClass("big-figure").wrap bigColumn
        $(@).addClass("big-figure")

  BlackInkGallery.prototype.close = (e) ->
    # example function

  $.fn.blackInkGallery = () ->
    return @each () -> new BlackInkGallery(@)

  $.fn.blackInkGallery.Constructor = BlackInkGallery

) jQuery
