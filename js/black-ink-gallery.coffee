(($) ->
  'use strict'

  # constructor function
  BlackInkGallery = (el) ->
    
    # TODO Need more intelligent way of determining images
    $figures = $(el).children()

    # Make sure we have data needed, e.g. image dimensions
    preprocessFigures = ($figures) ->
      
      numberOfFigures = $figures.length
      numberOfFiguresLoaded = 0

      # set up each image's width and height
      $figures.each (index) ->
        $image = $(@).find("img").first()

        # Webkit browsers set the height and width property 
        # after the image is loaded. Create a memory copy of 
        # each image and set its w and h on loading.
        $(new Image()).load( () ->
          console.log "#{@width}, #{@height}"
          $image.data "width", @width
          $image.data "height", @height
          processFigures($figures) if ++numberOfFiguresLoaded is numberOfFigures
        ).attr("src", $image.attr("src"))

    processFigures = ($figures) ->

      # defaults
      minHeight         = 500
      hwRatioThreshold  = 1.5
      figureGroup       = []

      $figures.each (index) ->

        $image = $(@).find("img").first()
        w = $image.data "width"; h = $image.data "height"
        if h > minHeight and h / w > hwRatioThreshold
          figureGroup.push $(@)
        else
          # TODO
          figureGroup.push $(@)

      # set up container
      windowHeight = $(window).height()
      $(el).addClass("black-ink-gallery horizontal").css "height", windowHeight
      $inner = $('<div class="big-inner"></div>')

      for $fg in figureGroup
        console.log "creating dom..."
        $column = $('<div class="big-figure-column"></div>')
        $figure = $('<div class="big-figure"></div>')
        $image  = $fg.find("img").first()
        if (caption = $image.attr("data-caption"))?
          try
            # if caption is a json string
            captions = JSON.parse caption
          catch e
            captions = caption: caption
          $caption = $('<figurecaption class="big-figurecaption"></figurecaption>')
          for className, text of captions
            $caption.append '<p class="' + className + '">' + text + '</p>'
        $inner.append $column.append $figure.append [$caption, $fg]

      $(el).html $inner

    preprocessFigures $figures

  BlackInkGallery.prototype.close = (e) ->
    # example function

  $.fn.blackInkGallery = () ->
    return @each () -> new BlackInkGallery(@)

  $.fn.blackInkGallery.Constructor = BlackInkGallery

) jQuery
