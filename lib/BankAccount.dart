import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class BankAccount extends StatefulWidget {
  const BankAccount({Key? key}) : super(key: key);

  @override
  _BankAccountState createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  final List<charts.Series<Statistic, String>> _chartData = [
    charts.Series<Statistic, String>(
      id: 'Statistics',
      domainFn: (statistic, _) => statistic.dayOfWeek,
      measureFn: (statistic, _) => statistic.netWorth,
      data: [
        Statistic('Mon', 60000),
        Statistic('Tue', 75000),
        Statistic('Wed', 80000),
        Statistic('Thu', 95000),
        Statistic('Fri', 110000),
        Statistic('Sat', 120000),
        Statistic('Sun', 90000),
      ],
    ),
  ];

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<int> _years = List.generate(DateTime.now().year - 2021 + 1, (index) => 2021 + index);

  String _selectedMonth = 'January';
  int _selectedYear = DateTime.now().year;
  String _selectedWeek = 'Week 1';

  String? _accountNumber;
  String? _initialBalance;
  bool _showForm = true;

  void _submitForm() {
    // Validate input
    if (_accountNumber != null && _initialBalance != null) {
      if (_isNumeric(_accountNumber!) && _isNumeric(_initialBalance!)) {
        setState(() {
          _showForm = false;
        });
        return;
      }
    }

    // Display error message if input is invalid
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please enter valid account number and initial balance.'),
      ),
    );
  }

  bool _isNumeric(String value) {
    if (value.isEmpty) return false;
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showForm
          ? Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back8.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Set the border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.white, // Set the shadow color
                    offset: Offset(0, 2), // Set the offset of the shadow
                    blurRadius: 4, // Set the blur radius of the shadow
                    spreadRadius: 0, // Set the spread radius of the shadow
                  ),
                ],
              ),
              width: 400, // Set the desired width
              height: 270, // Set the desired height
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create Bank Account',
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _accountNumber = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'initial balance',
                        labelStyle: TextStyle(color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _initialBalance = value;
                        });
                      },
                    ),
                    SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Create Account'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .deepPurpleAccent), // Set the desired background color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
          : Container(
        width: 10000,
        height: 10000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back8.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children :[
            Text(
              'Bank Account',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome to your finance area',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 16.0),
                Card(

                  color: Colors.purple,
                  elevation: 0.0, // Remove default card elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.4), // Set shadow color with opacity
                          offset: Offset(10, 10), // Adjust the offset of the shadow
                          blurRadius: 4, // Set the blur radius of the shadow
                          spreadRadius: -2, // Adjust the spread radius of the shadow
                        ),
                      ],
                    ),
                    width: 500, // Set the desired width
                    height: 300, // Set the desired height
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5.0,4,0,0),
                      child: Column(
                        children: [
                          Text(
                            'Account Number:  $_accountNumber',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Total Net Worth:  \$$_initialBalance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(width: 20.00,),
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 16.0),
                              Text(
                                'By Week',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              DropdownButton<String>(
                                value: _selectedWeek,
                                items: List.generate(52, (index) => 'Week ${index + 1}').map((week) {
                                  return DropdownMenuItem<String>(
                                    value: week,
                                    child: Text(week),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedWeek = value!;
                                  });
                                },
                              ),
                              SizedBox(width: 20,),
    Icon(Icons.date_range),
    SizedBox(width: 16.0),
    Text(
    'By Month',
    style: TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    ),
    ),
    Icon(Icons.calendar_today),
    SizedBox(width: 16.0),
    Text(
    'By Year',
    style: TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    ),
    ),
    SizedBox(width: 16.0),
    DropdownButton<int>(
    value: _selectedYear,
    items: _years.map((year) {
    return DropdownMenuItem<int>(
    value: year,
    child: Text(year.toString()),
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _selectedYear = value!;
    });
    },
    ),
    ],
    ),
    SizedBox(height: 16.0),
    Expanded(
    child: charts.BarChart(
    _chartData,
    animate: true,
    domainAxis: charts.OrdinalAxisSpec(
    renderSpec: charts.SmallTickRendererSpec(
    labelRotation: 45,
    ),
    ),
    primaryMeasureAxis: charts.NumericAxisSpec(
    tickProviderSpec: charts.BasicNumericTickProviderSpec(
    desiredTickCount: 6,
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
    ),
    ],
    ),
    ),
    ),
    );
  }
}

class Statistic {
  final String dayOfWeek;
  final int netWorth;

  Statistic(this.dayOfWeek, this.netWorth);
}