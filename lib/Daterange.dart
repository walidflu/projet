import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerBox extends StatefulWidget {
  @override
  _DateRangePickerBoxState createState() => _DateRangePickerBoxState();
}

class _DateRangePickerBoxState extends State<DateRangePickerBox> {
  DateTime? _startDate;
  DateTime? _endDate;
  void _resetDates() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
  }
  void _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.deepPurpleAccent.shade200, // Set the primary color to purple
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurpleAccent.shade200, // Set the primary color to purple
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.deepPurpleAccent.shade200, // Set the primary color to purple
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurpleAccent.shade200, // Set the primary color to purple
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select Dates'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectStartDate(context),
                    child: Text('Select Start Date'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _selectEndDate(context),
                    child: Text('Select End Date'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => _resetDates(),
                  child: Text('Reset',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
            ),
                ),

SizedBox(width: 140.0,),

                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _startDate != null && _endDate != null
                  ? 'Start: ${DateFormat('yyyy-MM-dd').format(_startDate!)} | End: ${DateFormat('yyyy-MM-dd').format(_endDate!)}'
                  : 'Select dates',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(
            width: 10,
            ),
            Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}