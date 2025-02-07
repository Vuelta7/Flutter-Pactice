import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int selectedHours = 0;
  int selectedMinutes = 7;
  int selectedSeconds = 0;

  List<Map<String, dynamic>> tasks = [
    {"icon": Icons.work, "label": "Study", "time": "00:09:00"},
    {"icon": Icons.timer, "label": "Rest", "time": "00:07:00"},
    {
      "icon": Icons.fitness_center,
      "label": "B Muscle Re...",
      "time": "00:02:00"
    },
    {
      "icon": Icons.hourglass_bottom,
      "label": "S Muscle Re...",
      "time": "00:00:30"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimeSelector(23, selectedHours, (value) {
                setState(() => selectedHours = value);
              }),
              Text(" h ", style: textStyle()),
              buildTimeSelector(59, selectedMinutes, (value) {
                setState(() => selectedMinutes = value);
              }),
              Text(" m ", style: textStyle()),
              buildTimeSelector(59, selectedSeconds, (value) {
                setState(() => selectedSeconds = value);
              }),
              Text(" s ", style: textStyle()),
            ],
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
            ),
            itemCount: tasks.length + 1,
            itemBuilder: (context, index) {
              if (index == tasks.length) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                );
              }
              var task = tasks[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(task["icon"], color: Colors.white),
                      Text(task["label"], style: textStyle(fontSize: 14)),
                      Text(task["time"],
                          style: textStyle(fontSize: 12, opacity: 0.7)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(width: 30),
              FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Icon(Icons.play_arrow),
                onPressed: () {},
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTimeSelector(
      int max, int selectedValue, Function(int) onSelected) {
    return Container(
      height: 100,
      width: 60,
      child: ListWheelScrollView.useDelegate(
        perspective: 0.005,
        diameterRatio: 1.5,
        physics: FixedExtentScrollPhysics(),
        itemExtent: 40,
        onSelectedItemChanged: onSelected,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Text(
              "$index",
              style: textStyle(
                  fontSize: 20, opacity: index == selectedValue ? 1.0 : 0.5),
            );
          },
          childCount: max + 1,
        ),
      ),
    );
  }

  TextStyle textStyle({double fontSize = 18, double opacity = 1.0}) {
    return GoogleFonts.roboto(
      color: Colors.white.withOpacity(opacity),
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }
}
