var s = Snap("#svg");
s.attr({width: 600, height: 300});

var refreshUrl = "/bots"
var rosterUrl = "/roster"
var refreshIntervalMs = 500

if (window.location.protocol == "file:") {
  refreshUrl = "test/bots.json"
  rosterUrl = "test/roster.json"
}

function updateDisplay(displayInfo) {
  updateBots(displayInfo.bots)
  displayEvents(displayInfo.events)
}

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

function displayEvents(events) {
  // Event list consists of zero or more sublists
  // Sublists can take two forms:
  //  - ["ping", <bot>], eg ["ping", "bot3"]
  //    Indicates a bot has sent a lidar ping
  //  - ["boom", <x>, <y>], eg ["boom", 132, 79]
  //    Indicates an explosion at those coordinates
}

function botSetup(botInfo) {
  var table = $("#contestants table");
  table.empty();

  for (bot in botInfo) {
    addToContestantList(bot, botInfo[bot]);
    addToArena(bot, botInfo[bot]);
  }
  setTimeout(refresh, 1000);
}

function addToContestantList(bot, botInfo) {
  var rowId = bot + "-row";
  var tr = '<tr id="' + rowId + '"></tr>';
  $("#contestants table").append(tr);

  var row = $("#" + rowId);
  row.append('<td><img src="' + botInfo.icon + '"/></td>');
  row.append('<td>' + botInfo.name + '</td>');
  row.append('<td id="' + bot + '-health">' + botInfo.health + '</td>');
}

function addToArena(bot, botInfo) {
  var url = botInfo.icon;
  var color = botInfo.color;
  Snap.load(url, function (f) {
      f.select("svg").attr({fill: color, width: "1.5em",
        height: "1.5em", x: "50", y: "20", id: bot});
      s.append(f);
    });
}

function refresh() {
  $.ajax({ url: refreshUrl, success: updateDisplay, dataType: "json"});
  if (refreshIntervalMs) {
    setTimeout(refresh, refreshIntervalMs);
  }
}

$( document ).ready(function() {
  $.ajax({ url: rosterUrl, success: botSetup, dataType: "json"});
});
