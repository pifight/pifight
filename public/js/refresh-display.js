var s = Snap("#svg");
s.attr({width: 600, height: 300});

$( document ).ready(function() {
  refresh();
});


function refresh() {
  Snap.load("bots/bot1.svg", function (f) {
      f.select("svg").attr({fill: "#bada55", width: "1.5em", height: "1.5em", x: "10", y: "10"});
      // g = f.select("g");
      s.append(f);
    });
  Snap.load("bots/bot2.svg", function (f) {
      f.select("svg").attr({fill: "#aaaaaa", width: "1.5em", height: "1.5em", x: "50", y: "20"});
      // g = f.select("g");
      s.append(f);
    });

  Snap.load("bots/bot3.svg", function (f) {
      f.select("svg").attr({fill: "#ad413a", width: "1.5em", height: "1.5em", x: "100", y: "20"});
      // g = f.select("g");
      s.append(f);
    });

  // $.ajax({ url: "server", success: function(data){
  //     //Update your dashboard gauge
  //     salesGauge.setValue(data.value);

  //     //Setup the next poll recursively
  //     poll();
  //   }, dataType: "json"});
}
