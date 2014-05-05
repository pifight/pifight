var s = Snap("#svg");
s.attr({width: 600, height: 300});


function updateBots(botInfo) {
  for (bot in botInfo) {
    if (bot) {
      if (s.select("#" + bot)) {
        s.select("#" + bot).attr({x: botInfo[bot].x, y: botInfo[bot].y});
        $("#" + bot + "-health").text(botInfo[bot].health);
      }
    }
  }
}

function botSetup(botInfo) {

  console.log(botInfo)
  for (bot in botInfo) {
    console.log(bot)
    console.log(botInfo[bot].icon);
    loadBotIcon(bot, botInfo[bot].icon, botInfo[bot].color);
  }
  setTimeout(refresh, 1000);
}

function loadBotIcon(bot, url, color) {
  Snap.load(url, function (f) {
      console.log("loaded: " + bot);
      f.select("svg").attr({fill: color, width: "1.5em",
        height: "1.5em", x: "50", y: "20", id: bot});
      s.append(f);
    });
}

function refresh() {
  $.ajax({ url: "bot-positions.json", success: updateBots, dataType: "json"});
  setTimeout(refresh, 500);
}

$( document ).ready(function() {
  $.ajax({ url: "bot-basics.json", success: botSetup, dataType: "json"});
});
