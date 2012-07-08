var canvas;
var ctx;
var x = 400;
var y = 300;
var dx = 2;
var dy = 4;
var WIDTH = 400;
var HEIGHT = 300;

var robot;


function circle(x,y,r) {
  ctx.beginPath();
  ctx.arc(x, y, r, 0, Math.PI*2, true);
  ctx.fill();
}

function rect(x,y,w,h) {
  ctx.beginPath();
  ctx.rect(x,y,w,h);
  ctx.closePath();
  ctx.fill();
}


function clear() {
  ctx.clearRect(0, 0, WIDTH, HEIGHT);
}

function init() {
  canvas = document.getElementById("canvas");
  ctx = canvas.getContext("2d");
  return setInterval(draw, 10);
}


function draw() {
  $.get(
      "position.json",
      {paramOne : 1, paramX : 'abc'},
      function(data) {
         robot = data;
      }
  );

  clear();
  ctx.fillStyle = "#FAF7F8";
  rect(0,0,WIDTH,HEIGHT);
  ctx.fillStyle = "#444444";
  circle(x, y, 10);

  if (x + dx > WIDTH || x + dx < 0)
    dx = -dx;
  if (y + dy > HEIGHT || y + dy < 0)
    dy = -dy;

  x += dx;
  y += dy;
}

init();

