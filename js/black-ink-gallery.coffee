(($) ->
  'use strict'

  # constructor function
  BlackInkGallery = (el, options) ->
    @$el = $(el)
    @options = options

    @$el.on "big.preprocessed", $.proxy(@processFigures, @)
    return
    
  # Make sure we have data needed, e.g. image dimensions
  BlackInkGallery.prototype.preprocessFigures = () ->

    $el = @$el
    numberOfFigures = ($figures = $el.children()).length
    numberOfFiguresLoaded = 0

    # set up each image's width and height
    $figures.each (index) ->
      $image = $(@).find("img").first()

      # Webkit browsers set the height and width property 
      # after the image is loaded. Create a memory copy of 
      # each image and set its w and h on loading.
      $(new Image()).load( () ->
        $image.data "width", @width
        $image.data "height", @height

        # NOTE The second parameters of `trigger()` is an array of arguments.
        $el.trigger("big.preprocessed", $figures) if ++numberOfFiguresLoaded is numberOfFigures
      ).attr("src", $image.attr("src"))

  BlackInkGallery.prototype.processFigures = (event, figures...) ->

    $figures = $(figures)

    if $('body')[0].style["-webkit-writing-mode"]?
      @$el.removeClass('vertical').addClass('horizontal')
      @horizontalScroll $figures
    else
      @$el.removeClass('horizontal').addClass('vertical')
      @verticalScroll $figures, numberOfColumns: 5

  BlackInkGallery.prototype.verticalScroll = ($figures, options) ->

    { numberOfColumns } = options
    $inner = $('<div class="big-inner"></div>')

    # initialize
    $columns = []; columnHeights = []
    for i in [0..numberOfColumns-1]
      $columns[i] = $('<div class="big-figure-column"></div>')
      columnHeights[i] = 0

    $figures.each (index, figure) =>
      shortestIndex = 0; shortest = columnHeights[shortestIndex]
      for v, i in columnHeights
        if v < shortest
          shortestIndex = i; shortest = v
      $columns[shortestIndex].append @makeFigure $(figure)
      columnHeights[shortestIndex] += $(figure).find("img").first().data "height"

    @$el.html $inner.append $columns

  BlackInkGallery.prototype.makeFigure = ($original) ->

    $figure  = $('<div class="big-figure"></div>')
    $caption = $('<figurecaption class="big-figurecaption"></figurecaption>')
    $image   = $original.find("img").first()

    if (caption = $image.attr("data-caption"))?
      try
        # if caption is a json string
        captions = JSON.parse caption
      catch e
        captions = caption: caption

      for className, text of captions
        $caption.append '<p class="' + className + '">' + text + '</p>'

    $figure.append [$caption, $original]

  BlackInkGallery.prototype.makeColumns = ($figures) ->


  BlackInkGallery.prototype.horizontalScroll = ($figures, options) ->

    $el = @$el

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
    $el.addClass("black-ink-gallery horizontal").css "height", windowHeight
    $inner = $('<div class="big-inner"></div>')

    for $fg in figureGroup
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

    $el.html $inner

  $.fn.blackInkGallery = () ->
    return @each () -> (new BlackInkGallery(@)).preprocessFigures()

) jQuery
