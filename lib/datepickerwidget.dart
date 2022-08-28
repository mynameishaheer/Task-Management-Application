import 'package:flutter/material.dart';

// ignore: camel_case_types
class DateTimePicker_Widget extends StatefulWidget {
  const DateTimePicker_Widget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  final Function onClicked;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker_Widget> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        primary: Colors.white,
        alignment: Alignment.centerLeft,
        elevation: 0,
        side: const BorderSide(color: Colors.grey),
      ),
      child: FittedBox(
        child: Text(
          'Due Date: ${getText()}',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey[700]),
        ),
      ),
      onPressed: () async {
        await pickDate(context);
        widget.onClicked(date);
      },
    );
  }

  String getText() {
    if (date == null) {
      return "";
    } else {
      return '${date?.day}/${date?.month}/${date?.year}';
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2023),
    );
    if (newDate == null) {
      return;
    } else {
      date = newDate;
      setState(() {});
    }
  }
}
