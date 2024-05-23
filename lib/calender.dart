
import 'package:flutter/material.dart';
import 'package:mypetplant/Home.dart';
import 'package:table_calendar/table_calendar.dart';

class calender extends StatefulWidget {
  final List<DateTime>? wateredDate;
  const calender({Key? key, this.wateredDate}) : super(key: key);

  State<calender> createState() => _CalendarState();
}
  class _CalendarState extends State<calender>{

    Map<DateTime, List<event>> water = {};

    @override
    void initState() {
      super.initState();
      _initializeWaterEvents(widget.wateredDate);
    }


    void _initializeWaterEvents(List<DateTime>? dates) {
      if(dates != null)
        for (var date in dates) {
          DateTime wateredDate = DateTime.utc(date.year, date.month, date.day);
          if(water.containsKey(wateredDate))
            water[wateredDate]!.add(event(''));
          else
            water[wateredDate] = [event('')];
        }
    }

    List<event> _getEventsForDay(DateTime day) {
      DateTime wateredDay = DateTime.utc(day.year, day.month, day.day);
      return water[wateredDay] ?? [];
    }

    DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  int background = 0xffb3c458;
  int foreground = 0xffdce4ae;
  double horizontalPadding = 10;
  var _focusedDay = DateTime.now(); //focusedDay에 할당할 날짜

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          color : Color(background),
          child : Padding(
            padding: EdgeInsets.symmetric(vertical : screenHeight * 0.04, horizontal: horizontalPadding),
            child : Column(
              children : [
                TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: format,

                  onFormatChanged: (CalendarFormat format) {
                    setState(() {
                      this.format = format;
                      _focusedDay = focusedDay;
                    });
                  },
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    setState((){
                      if(selectedDay == this.selectedDay && focusedDay == _focusedDay) {
                        changeCalendarFormat();
                        this.selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      }
                      else{
                        changeCalendarFormat();
                        this.selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      }
                    });
                  },

                  selectedDayPredicate: (DateTime day) {
                    return isSameDay(selectedDay, day);
                  },
                  headerStyle : HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    leftChevronIcon: Image(image: AssetImage('assets/images/leftarrow.png'), width: 20, height: 20),
                    rightChevronIcon: Image(image: AssetImage('assets/images/rightarrow.png'), width: 20, height: 20),
                    leftChevronVisible: true,
                    rightChevronVisible: true,
                    leftChevronMargin: EdgeInsets.only(left : 65),
                    rightChevronMargin: EdgeInsets.only(right: 65),
                    headerMargin: EdgeInsets.symmetric(vertical: 5),

                  ),
                  calendarStyle: CalendarStyle(
                    markersAutoAligned: true,
                    markerSize: 30,
                    markersAlignment: Alignment.bottomCenter,
                    markersMaxCount: 1,
                    markerMargin: EdgeInsets.only(top:10),
                    cellAlignment: Alignment.center,
                    cellMargin: EdgeInsets.only(bottom:screenHeight/12),
                    markerDecoration: BoxDecoration(
                      image : DecorationImage(image : AssetImage('assets/images/marker.png')),
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: const Color(0xFF81AE17),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                    defaultTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    weekendTextStyle: const TextStyle(
                      fontSize : 18,
                      fontWeight: FontWeight.bold
                    ),
                    outsideTextStyle: const TextStyle(
                        fontSize : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                    todayTextStyle: const TextStyle(
                        fontSize : 18,
                        fontWeight: FontWeight.bold
                    ),
                    rowDecoration: BoxDecoration(
                      color: Color(foreground),
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: const TextStyle(
                    fontSize : 18,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: const TextStyle(
                      fontSize : 18,
                      fontWeight: FontWeight.bold,
                  ),
                  decoration: BoxDecoration(
                    color: Color(foreground),
                  ),
                ),
                daysOfWeekHeight: 50,
                rowHeight: screenHeight/8,
                eventLoader: _getEventsForDay,
              ),
              ]
            )
        )
      ),

      floatingActionButton : FloatingActionButton(
        child : Padding(
            padding: EdgeInsets.all(10),
            child : Image(image: AssetImage('assets/images/home.png'))),
        backgroundColor: Color(0xFF81AE17),
        shape: CircleBorder(),
        onPressed:(){
          Navigator.of(context).pop();
        }),
    );
  }
  void changeCalendarFormat(){
    if(format==CalendarFormat.month){
      format = CalendarFormat.week;
      background = 0xffffffff;
      foreground = 0xffffffff;
    }
    else if(format == CalendarFormat.week){
      format = CalendarFormat.month;
      background = 0xffb3c458;
      foreground = 0xffdce4ae;
    }
  }
}

class event {
  String time;
  event(this.time);
}

