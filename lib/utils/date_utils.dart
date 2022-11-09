import 'package:expense_tracker_v2/constants/content.dart';

final now = DateTime.now();

final yesterday = DateTime(now.year, now.month, now.day - 1);
bool isSameDate(DateTime date) =>
    date.year == now.year && date.month == now.month && date.day == now.day;

bool isYesterday(DateTime date) =>
    date.year == yesterday.year &&
    date.month == yesterday.month &&
    date.day == yesterday.day;
bool isSameDay(DateTime d1, DateTime d2) =>
    d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;

String formatDate(DateTime dateTime) =>
    '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}';

String weekDayName(int weekday) => daysOfTheWeek[weekday - 1];

DateTime get mostRecentMondayFromCurrentDay =>
    DateTime(now.year, now.month, now.day - (now.weekday - 1));

// final List<DateTime> _thisWeek = [];
// List<DateTime> get thisWeek => _thisWeek;

// void createThisWeek() {

// }

List<DateTime> getThisWeek() {
  List<DateTime> list = [];
  for (int i = 0; i < 7; i++) {
    list.add(
      mostRecentMondayFromCurrentDay.add(
        Duration(days: i),
      ),
    );
  }
  return list;
}
