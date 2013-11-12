$ () ->
  picture = $ '#picture'
  target = $ '#target'
  reset = $ '#reset'
  increment = $ '#increment'
  current = $ '#current'
  height = picture.height()
  width = picture.width()
  stage = new createjs.Stage 'picture'
  bg = new createjs.Shape()
  cover = new createjs.Shape()
  tiles = []
  img = null

  loadImage = () ->
    loader = new Image()

    loader.onload = () ->
      img = new createjs.Bitmap loader

      reset()

    loader.src = 'img.jpg'

  updateFilter = () ->
    cover.updateCache 0, 0, width, height

    img.filters = [
      new createjs.AlphaMaskFilter cover.cacheCanvas
    ]

    img.updateCache 0, 0, width, height

    stage.update()

  reset = () ->
    bg.graphics.clear()
    cover.graphics.clear()
    stage.clear()

    cover.cache 0, 0, width, height
    img.cache 0, 0, width, height

    updateFilter()

    stage.addChild bg, cover, img

    calculate()

  calculate = () ->
    sqrt = Math.floor Math.sqrt target.val()
    total = Math.pow sqrt, 2
    tiles = new Array total

    $.each tiles, (index) ->
      # cheap and dirty, just like me
      tiles[index] = index

    tiles = tiles.sort () ->
      .5 - Math.random()

    drawBg()

  drawBg = () ->
    bgGfx = bg.graphics

    bgGfx.f '#ff0000'
    bgGfx.dr 0, 0, width, height

    stage.update()

  increment.click () ->
    tile = tiles.pop()
    coverGfx = cover.graphics

    coverGfx.f '#ffff00'
    coverGfx.dr 10, 10, 10, 10

    updateFilter()

  loadImage()