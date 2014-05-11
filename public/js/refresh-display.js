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
  $("#debug").append("<p>FOO</p>");
  var table = $("#contestants table");
  table.empty();

  for (bot in botInfo) {
    console.log(bot);
    console.log(botInfo[bot].icon);
    rowId = bot + "-row";
    var tr = '<tr id="' + rowId + '"></tr>';
    table.append(tr);
    loadBotIcon(bot, botInfo[bot], rowId);
  }
  setTimeout(refresh, 1000);
}

function loadBotIcon(bot, botInfo, rowId) {
  var url = botInfo.icon;
  var color = botInfo.color;
  row = $("#" + rowId);
  row.append('<td><img src="' + url + '"/></td>')
  row.append('<td>' + botInfo.name + '</td>')
  row.append('<td>' + botInfo.health + '</td>')
}

function refresh() {
  $.ajax({ url: "bot-positions.json", success: updateBots, dataType: "json"});
  setTimeout(refresh, 500);
}

$( document ).ready(function() {
  $.ajax({ url: "bot-basics.json", success: botSetup, dataType: "json"});
});
