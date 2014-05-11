var s = Snap("#svg");
s.attr({width: 600, height: 300});


function updateBots(botInfo) {
  console.log("updateBots");
  for (bot in botInfo) {
    console.log("updateBots: " + bot);
    if (bot) {
      if (s.select("#" + bot)) {
        s.select("#" + bot).attr({x: botInfo[bot].x, y: botInfo[bot].y});
        console.log("#" + bot + "-health");
        $("#" + bot + "-health").text(botInfo[bot].health);
      }
    }
  }
}

function botSetup(botInfo) {
  $("#debug").append("<p>FOO</p>");
  var table = $("#contestants table");
  table.empty();

  for (bot in botInfo) {
    addToContestantList(bot, botInfo[bot]);
    addToArena(bot, botInfo[bot]);
  }
  setTimeout(refresh, 1000);
}

function addToContestantList(bot, botInfo) {
  console.log("addToContestantList: " + bot);
  var rowId = bot + "-row";
  var tr = '<tr id="' + rowId + '"></tr>';
  $("#contestants table").append(tr);

  var row = $("#" + rowId);
  row.append('<td><img src="' + botInfo.icon + '"/></td>');
  row.append('<td>' + botInfo.name + '</td>');
  row.append('<td id="' + bot + '-health">' + botInfo.health + '</td>');
  console.log("BAZ");
}

function addToArena(bot, botInfo) {
  var url = botInfo.icon;
  var color = botInfo.color;
  Snap.load(url, function (f) {
      console.log("loaded: " + bot);
      f.select("svg").attr({fill: color, width: "1.5em",
        height: "1.5em", x: "50", y: "20", id: bot});
      s.append(f);
    });
}

function refresh() {
  $.ajax({ url: "bot-positions.json", success: updateBots, dataType: "json"});
  // setTimeout(refresh, 500);
}

$( document ).ready(function() {
  $.ajax({ url: "bot-basics.json", success: botSetup, dataType: "json"});
});
