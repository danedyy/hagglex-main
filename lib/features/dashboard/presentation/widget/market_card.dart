import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hagglex/core/share_ui/shared/ui_helpers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MarketCard extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  final int color;
  List<LinearSales> data;
  MarketCard({
    Key key,
    this.title,
    this.subTitle,
    this.icon,
    this.color,
    this.data,
  }) : super(key: key);

  @override
  _MarketCardState createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      widget.data =
          List.generate(20, (index) => LinearSales(index, Random().nextInt(10)))
              .toList();
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(.06),
                  child: widget.icon,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 14, fontFamily: 'BasisRegular'),
                    ),
                    verticalSpaceTiny,
                    Row(
                      children: [
                        Text(
                          widget.subTitle,
                          style:
                              TextStyle(fontSize: 10, fontFamily: 'BasisLight'),
                        ),
                        horizontalSpaceTiny,
                        Text(
                          '+2.34%',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'BasisRegular',
                              color: Color(0xff52CB35)),
                        )
                      ],
                    )
                  ],
                )
                // verticalSpaceLarge
              ],
            ),
            Container(
              height: 70,
              width: 120,
              padding: EdgeInsets.zero,
              // color: Colors.amber,
              child: AreaAndLineChart(
                createSampleData(),
                animate: true,
              ),
            ),
          ],
        ),
        // verticalSpaceTiny,
        Divider(
          thickness: 1.1,
        )
      ],
    );
  }

  List<charts.Series<LinearSales, int>> createSampleData() {
    return [
      charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(widget.color)),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: widget.data,
      )
        // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customArea'),
    ];
  }
}

class AreaAndLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  AreaAndLineChart(this.seriesList, {this.animate});
  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList,
        animate: animate,
        domainAxis: charts.NumericAxisSpec(
            showAxisLine: false, renderSpec: charts.NoneRenderSpec()),
        primaryMeasureAxis: charts.NumericAxisSpec(
            showAxisLine: false, renderSpec: charts.NoneRenderSpec()),
        customSeriesRenderers: [
          charts.LineRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customArea',
            roundEndCaps: true,
            includeArea: true,
            strokeWidthPx: .5,
          ),
        ]);
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
