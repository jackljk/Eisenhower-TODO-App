import 'package:intl/intl.dart';


DateTime parseDate(String inputDate) {
  DateFormat format = DateFormat('MM/dd/yyyy');
  return format.parse(inputDate);
}

DateTime? parseTime(String? inputTime) {
  if (inputTime == null) {
    return null;
  }
  DateFormat format12Hour = DateFormat('hh:mm a');
  DateFormat format24Hour = DateFormat('HH:mm');
  try {
    return format12Hour.parse(inputTime);
  } catch (e) {
    try {
      return format24Hour.parse(inputTime);
    } catch (e) {
      return null;
    }
  }
}


String displayDate(DateTime dateTime) {
  // Create a DateFormat object using the MM/DD/YY pattern
  DateFormat format = DateFormat('MM/dd/yy');
  // Use the DateFormat object to format the DateTime
  return format.format(dateTime);
}

String displayTime(DateTime? dateTime) {
  if (dateTime == null) {
    return '';
  }
  // Create a DateFormat object using the HH:MM pattern
  DateFormat format = DateFormat('hh:mm a');
  // Use the DateFormat object to format the DateTime
  return format.format(dateTime);
}
