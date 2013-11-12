$ () ->
  picture = $ '#picture'
  target = $ '#target'
  current = $ '#current'
  height = picture.height()
  width = picture.width()
  stage = new createjs.Stage 'picture'
  bg = new createjs.Shape()
  cover = new createjs.Shape()
  tiles = []
  count = 0
  size = 0
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
    count = 0

    bg.graphics.clear()
    cover.graphics.clear()
    stage.clear()

    current.text count
    cover.cache 0, 0, width, height
    img.cache 0, 0, width, height

    updateFilter()

    stage.addChild bg, cover, img

    calculate()

  calculate = () ->
    sqrt = Math.floor Math.sqrt target.val()
    total = Math.pow sqrt, 2
    tiles = new Array total
    size = width / sqrt

    $.each tiles, (index) ->
      x = (index % sqrt) * size
      y = (Math.floor index / sqrt) * size
      tiles[index] = [x, y]

    tiles = tiles.sort () ->
      .5 - Math.random()

    drawBg()

  drawBg = () ->
    bgGfx = bg.graphics

    bgGfx.f '#ff0000'
    bgGfx.dr 0, 0, width, height

    stage.update()

  $('#increment').click () ->
    tile = tiles.pop()
    coverGfx = cover.graphics

    coverGfx.f '#ffff00'
    coverGfx.dr tile[0], tile[1], size, size

    current.text ++count

    updateFilter()

  $('#reset').click reset

  loadImage()