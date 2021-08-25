import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";

am4core.ready(function() {
  am4core.useTheme(am4themes_animated);
  var chartID = document.querySelector("#ampieChart")
  var chart = am4core.create('ampieChart', am4charts.PieChart);
  chart.hiddenState.properties.opacity = 0;
  console.log(chartID.dataset.pie)
  chart.data = JSON.parse(chartID.dataset.pie);
  console.log(chart.data)
  
  var series = chart.series.push(new am4charts.PieSeries());
  series.dataFields.value = "goal_value";
  series.dataFields.radiusValue = "goal_value";
  series.dataFields.category = "goal_name";
  series.slices.template.cornerRadius = 6;
  series.colors.step = 5;
  series.labels.template.maxWidth = 130;
  series.labels.template.wrap = true;
  //series.labels.template.truncate = true;
  series.hiddenState.properties.endAngle = -90;
  series.labels.template.text = "{goal_name}";
  
  });