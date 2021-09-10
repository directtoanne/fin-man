am4core.ready(function () {
  // Themes begin
  am4core.useTheme(am4themes_dark);
  am4core.useTheme(am4themes_animated);
  // Themes end

  // Find elements and dataset
  const elements = document
    .querySelector(".counter-main")
    .querySelectorAll(".dash-chart");

  if (elements) {
    elements.forEach((element) => {
      // Create chart instance
      var chart = am4core.create(element, am4charts.XYChart);
      const data = element.dataset.chartdata
      chart.scrollbarX = new am4core.Scrollbar();

      // Add data
      chart.data = JSON.parse(data);

      // Create axes
      var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
      categoryAxis.dataFields.category = "name";
      categoryAxis.renderer.grid.template.location = 0;
      categoryAxis.renderer.minGridDistance = 30;
      categoryAxis.renderer.labels.template.horizontalCenter = "right";
      categoryAxis.renderer.labels.template.verticalCenter = "middle";
      categoryAxis.renderer.labels.template.rotation = 270;
      categoryAxis.tooltip.disabled = true;
      categoryAxis.renderer.minHeight = 110;

      var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
      valueAxis.renderer.minWidth = 50;

      // Create series
      var series = chart.series.push(new am4charts.ColumnSeries());
      series.sequencedInterpolation = true;
      series.dataFields.valueY = "amount";
      series.dataFields.categoryX = "name";
      series.tooltipText = "[{categoryX}: bold]{valueY}[/]";
      series.columns.template.strokeWidth = 0;

      series.tooltip.pointerOrientation = "vertical";

      series.columns.template.column.cornerRadiusTopLeft = 10;
      series.columns.template.column.cornerRadiusTopRight = 10;
      series.columns.template.column.fillOpacity = 0.8;

      // on hover, make corner radiuses bigger
      var hoverState = series.columns.template.column.states.create("hover");
      hoverState.properties.cornerRadiusTopLeft = 0;
      hoverState.properties.cornerRadiusTopRight = 0;
      hoverState.properties.fillOpacity = 1;

      series.columns.template.adapter.add("fill", function (fill, target) {
        return chart.colors.getIndex(target.dataItem.index);
      });

      // Cursor
      chart.cursor = new am4charts.XYCursor();
    });
  }
}); // end am4core.ready()
