var s = Snap("#svg");
s.attr({width: 600, height: 300});

$( document ).ready(function() {
  botSetup();
  refresh();
});

function updateBots(botInfo) {
  for (bot in botInfo) {
    s.select("#" + bot).attr({x: botInfo[bot].x, y: botInfo[bot].y})
  }
}

function botSetup() {
  Snap.load("bots/bot1.svg", function (f) {
      f.select("svg").attr({fill: "#bada55", width: "1.5em",
        height: "1.5em", x: "10", y: "10", id: "bot1"});
      // g = f.select("g");
      s.append(f);
    });
  Snap.load("bots/bot2.svg", function (f) {
      f.select("svg").attr({fill: "#aaaaaa", width: "1.5em",
        height: "1.5em", x: "50", y: "20", id: "bot2"});
      // g = f.select("g");
      s.append(f);
    });

  Snap.load("bots/bot3.svg", function (f) {
      f.select("svg").attr({fill: "#ad413a", width: "1.5em",
        height: "1.5em", x: "100", y: "20", id: "bot3"});
      // g = f.select("g");
      s.append(f);
    });
}

function refresh() {
  $.ajax({ url: "bot-positions.json", success: updateBots, dataType: "json"});
  setTimeout(refresh, 500);
}
