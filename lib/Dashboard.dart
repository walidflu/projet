import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Daterange.dart';
import 'Notifications.dart';
import 'package:charts_flutter/flutter.dart' as charts;




class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  Widget _buildSalesChart() {
    List<SalesData> data = [
      SalesData('Jan', 100),
      SalesData('Feb', 200),
      SalesData('Mar', 150),
      // Add more data points as needed
    ];

    return charts.LineChart(
      _createSeriesData(data).cast<charts.Series<dynamic, num>>(),
      animate: true,
      defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
      primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
              fontSize: 16,
              color: charts.Color.white
          ),
        ),
      ),
    );
  }

  List<charts.Series<SalesData, String>> _createSeriesData(List<SalesData> data) {
    return [
      charts.Series<SalesData, String>(
        id: 'sales',
        colorFn: (_, __) => charts.Color.white,
        areaColorFn: (_, __) => charts.Color(r: 0, g: 255, b: 0),
        domainFn: (SalesData sales, _) => sales.month,
        measureFn: (SalesData sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
  NotificationsManager _notificationsManager = NotificationsManager();
  List<Notifications> _notifications = [];
  bool isExpanded = false;
  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    return formattedTime;
  }
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }
  void _loadNotifications() {
    setState(() {
      _notifications = _notificationsManager.getNotificationsFromDatabase().cast<Notifications>();
    });
  }
  void _showNotificationWindow() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationsScreen()),
    );
  }
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
        builder: (context, constraints) {
          var data;
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DateRangePickerBox(),
                            IconButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder: (BuildContext context,
                                      Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: Colors.deepPurple,
                                        // Set the primary color to purple
                                        colorScheme: ColorScheme.light(
                                          primary: Colors
                                              .deepPurple, // Set the primary color to purple
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    selectedDate = picked;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.grey,
                                size: 30.0,
                              ),
                            ),

                            Text(
                              DateFormat('dd/MM/yyyy').format(selectedDate),
                              style: TextStyle(fontSize: 18.0),
                            ),


                            SizedBox(
                              width: 10.0,
                            ),
                            Stack(
                              children: [IconButton(
                                icon: Icon(
                                  Icons.notification_important_outlined,
                                  color: Colors.grey,
                                  size: 30.0,
                                ),
                                onPressed: _showNotificationWindow,


                              ),
                                Positioned(
                                  top: 7,
                                  right: 7,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Colors.redAccent, width: 2),),
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(
                              width: 15.0,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  radius: 35.0,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Adjust Flexible with responsive width
                            Flexible(
                              flex: constraints.maxWidth < 600 ? 1 : 2,
                              child: Card(
                                color: Colors.greenAccent.shade400,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.monetization_on_outlined,
                                              color: Colors.white, size: 26.0),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "TOTAL INCOME",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "0.00 £",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Receivables",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 85.0,
                                          ),
                                          Text(
                                            "0.00£/0.00£",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: constraints.maxWidth < 600 ? 1 : 2,
                              child: Card(
                                color: Colors.blue.shade600,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_purple500,
                                            size: 26.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "TOTAL PROFIT",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "0.00 £",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Upcoming",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.0,
                                          ),
                                          Text(
                                            "0.00£/0.00£",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: constraints.maxWidth < 600 ? 1 : 2,
                              child: Card(
                                color:
                                Colors.redAccent.shade400,
                                // set background color here

                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_cart,
                                            size: 26.0,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text(
                                            "TOTAL EXPENSES",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "0.00 £",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Payables",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100.0,
                                          ),
                                          Text(
                                            "0.00£/0.00£",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "INCOMES : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 15.0,
                              width: 50.0,
                              color: Colors.greenAccent.shade400,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "TOTAL PROFIT : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 15.0,
                              width: 50.0,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "OUTCOMES : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: 15.0,
                              width: 50.0,
                              color: Colors.redAccent.shade400,
                            ),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple, // Purple background
                            ),
                            child: charts.LineChart(
                              [
                                charts.Series<SalesData, String>(
                                  id: 'Sales',
                                  domainFn: (SalesData sales, _) => sales.month,
                                  measureFn: (SalesData sales, _) => sales.sales,
                                  colorFn: (_, __) => charts.Color(r: 255, g: 255, b: 255),
                                  data: data,
                                )
                              ],
                              animate: true,
                              primaryMeasureAxis: charts.NumericAxisSpec(
                                renderSpec: charts.GridlineRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                    color: charts.MaterialPalette.white, // White labels on OY axis
                                  ),
                                  lineStyle: charts.LineStyleSpec(
                                    color: charts.Color(r: 255, g: 255, b: 255, a: 128),
                                  ),
                                ),
                                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                                  desiredTickCount: 6, // Number of ticks on OY axis
                                ),
                                tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                                      (num? value) => '\$${value!.toInt()}',
                                ),
                                viewport: charts.NumericExtents(0, 450), // Adjust the maximum value of OY axis if needed
                              ),
                              domainAxis: charts.OrdinalAxisSpec(
                                renderSpec: charts.SmallTickRendererSpec(
                                  labelStyle: charts.TextStyleSpec(
                                    color: charts.MaterialPalette.white, // White labels on OX axis
                                  ),
                                  lineStyle: charts.LineStyleSpec(
                                  ),
                                ),
                              ),
                              defaultRenderer: charts.LineRendererConfig(
                                includeArea: true, // Enable shading below the line
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
    ),

    );
  }
  }
class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}