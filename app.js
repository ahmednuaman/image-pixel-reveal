$(function() {
  var bg, calculate, count, cover, current, drawBg, height, img, loadImage, picture, reset, size, stage, target, tiles, updateFilter, width;
  picture = $('#picture');
  target = $('#target');
  current = $('#current');
  height = picture.height();
  width = picture.width();
  stage = new createjs.Stage('picture');
  bg = new createjs.Shape();
  cover = new createjs.Shape();
  tiles = [];
  count = 0;
  size = 0;
  img = null;
  loadImage = function() {
    var loader;
    loader = new Image();
    loader.onload = function() {
      img = new createjs.Bitmap(loader);
      return reset();
    };
    return loader.src = 'img.jpg';
  };
  updateFilter = function() {
    cover.updateCache(0, 0, width, height);
    img.filters = [new createjs.AlphaMaskFilter(cover.cacheCanvas)];
    img.updateCache(0, 0, width, height);
    return stage.update();
  };
  reset = function() {
    count = 0;
    bg.graphics.clear();
    cover.graphics.clear();
    stage.clear();
    current.text(count);
    cover.cache(0, 0, width, height);
    img.cache(0, 0, width, height);
    updateFilter();
    stage.addChild(bg, cover, img);
    return calculate();
  };
  calculate = function() {
    var sqrt, total;
    sqrt = Math.floor(Math.sqrt(target.val()));
    total = Math.pow(sqrt, 2);
    tiles = new Array(total);
    size = width / sqrt;
    $.each(tiles, function(index) {
      var x, y;
      x = (index % sqrt) * size;
      y = (Math.floor(index / sqrt)) * size;
      return tiles[index] = [x, y];
    });
    tiles = tiles.sort(function() {
      return .5 - Math.random();
    });
    return drawBg();
  };
  drawBg = function() {
    var bgGfx;
    bgGfx = bg.graphics;
    bgGfx.f('#ff0000');
    bgGfx.dr(0, 0, width, height);
    return stage.update();
  };
  $('#increment').click(function() {
    var coverGfx, tile;
    tile = tiles.pop();
    coverGfx = cover.graphics;
    coverGfx.f('#ffff00');
    coverGfx.dr(tile[0], tile[1], size, size);
    current.text(++count);
    return updateFilter();
  });
  $('#reset').click(reset);
  return loadImage();
});

/*
//@ sourceMappingURL=app.js.map
*/