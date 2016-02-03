$(function() {
  if (typeof(dataset) !== 'undefined') {
    buildGraph();
  }
});

var buildGraph = function() {
  var w = 400;
  var h = 240;
  var padding = 90;

  var svg = d3.select("#graph")
              .append("svg")
              .attr({ width: w, height: h });

// initialize with static circles
  var bars = svg.selectAll("circle")
                .data(dataset)
                .enter()
                .append("circle")
                .attr({
                  fill: 'antiquewhite',
                  stroke: "white",
                  cx: function(d, i) {return i * 110 + padding;},
                  cy: 70,
                  r: 50 //function(d) {return d * 5;},
                })
                .style('stroke-width', 2);

  var xAxis = d3.svg.axis()
                    .scale( d3.scale.linear()
                                    .domain([0, 3])
                                    .range([0, w - padding/2]))
                    .orient("top")
                    .ticks(0);

// add bottom grid line
  svg.append("g")
     .classed("axis", true)
     .call(xAxis)
     .attr({
      transform: "translate(30, 180)",
      fill: 'none',
      stroke: '#33cccc'
     });

// add labels for circles
  svg.selectAll("text")
     .data([["Luminence",55], ["Color variety",155], ["Contrast",280] ] )
     .enter()
     .append("text")
     .text(function(d) {return d[0];})
     .attr({
      x: function(d) {return d[1]},
      y: 160,
      fill: "#33cccc",
      'font-size': 13,
      'text-transform': 'lowercase'
     });

// after load, animate to proper size
  window.setTimeout(function() {
    svg.selectAll("circle")
       .data(dataset)
       .transition()
       .duration(2000)
       .ease("quad")
       .attr({
        r: function(d) {return d * 5;},
        fill: svgColor
       })
       .style("fill-opacity", function(d) {return d/10;} )
    }, 1500);
};





