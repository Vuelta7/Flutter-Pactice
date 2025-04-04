// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:learn_n/components/color_utils.dart';
// import 'package:learn_n/start%20page/start%20page%20utils/start_page_button.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timezone/timezone.dart' as tz;

// void main() async {
//   await NotificationService.init();

//   runApp(NotificationPage());
// }

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});

//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage>
//     with WidgetsBindingObserver {
//   TimeOfDay? selectedTime;
//   bool isNotificationSet = false;
//   bool _isDisposed = false;
//   bool _notificationsAllowed = false;
//   List<int> timeIntervals = [5, 10, 15, 20, 25, 30];
//   int? selectedInterval;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     NotificationService.init();
//     _checkNotificationPermission();
//     _loadPreferences();
//   }

//   Future<void> _checkNotificationPermission() async {
//     final status = await Permission.notification.status;
//     setState(() {
//       _notificationsAllowed = status.isGranted;
//     });
//   }

//   Future<void> _requestNotificationPermission() async {
//     final status = await Permission.notification.request();
//     setState(() {
//       _notificationsAllowed = status.isGranted;
//     });
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _loadPreferences();
//       _checkNotificationPermission();
//     }
//   }

//   Future<void> _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (_isDisposed) return;

//     final int? scheduledEpoch = prefs.getInt('scheduledEpoch');
//     if (scheduledEpoch != null) {
//       DateTime scheduledTime =
//           DateTime.fromMillisecondsSinceEpoch(scheduledEpoch);
//       if (DateTime.now().isAfter(scheduledTime)) {
//         setState(() {
//           isNotificationSet = false;
//           selectedTime = null;
//           selectedInterval = null;
//         });
//         await prefs.remove('scheduledEpoch');
//         await prefs.setBool('isNotificationSet', false);
//       }
//     }

//     setState(() {
//       selectedInterval = prefs.getInt('selectedInterval');
//       if (selectedInterval != null &&
//           !timeIntervals.contains(selectedInterval)) {
//         selectedInterval = null;
//       }
//       isNotificationSet = prefs.getBool('isNotificationSet') ?? false;

//       final hour = prefs.getInt('selectedTimeHour');
//       final minute = prefs.getInt('selectedTimeMinute');
//       if (hour != null && minute != null) {
//         selectedTime = TimeOfDay(hour: hour, minute: minute);
//       }
//     });
//   }

//   Future<void> _savePreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('selectedInterval', selectedInterval ?? 0);
//     await prefs.setBool('isNotificationSet', isNotificationSet);
//     if (selectedTime != null) {
//       await prefs.setInt('selectedTimeHour', selectedTime!.hour);
//       await prefs.setInt('selectedTimeMinute', selectedTime!.minute);
//     } else {
//       await prefs.remove('selectedTimeHour');
//       await prefs.remove('selectedTimeMinute');
//     }
//   }

//   Future<void> _pickTime() async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (picked != null && picked != selectedTime) {
//       final now = DateTime.now();
//       final notificationTime = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         picked.hour,
//         picked.minute,
//       );

//       if (notificationTime.isAfter(now)) {
//         setState(() {
//           selectedTime = picked;
//           isNotificationSet = true;
//           selectedInterval = null;
//         });
//         _savePreferences();
//         _scheduleNotification(picked);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please pick a future time!")),
//         );
//       }
//     }
//   }

//   void _scheduleNotification(TimeOfDay time) async {
//     final now = DateTime.now();
//     final scheduledDateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );

//     if (scheduledDateTime.isAfter(now)) {
//       await NotificationService.scheduleNotification(
//         scheduledDateTime,
//         'Time to Study!',
//         'Keep pushing forward — your future self will thank you!',
//       );

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setInt(
//           'scheduledEpoch', scheduledDateTime.millisecondsSinceEpoch);

//       setState(() {
//         isNotificationSet = true;
//       });
//       _savePreferences();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please pick a future time!")),
//       );
//     }
//   }

//   void _scheduleIntervalNotification(int interval) async {
//     final now = DateTime.now();
//     final scheduledDateTime = now.add(Duration(minutes: interval));

//     await NotificationService.scheduleNotification(
//       scheduledDateTime,
//       'Time to Study!',
//       'Keep pushing forward — your future self will thank you!',
//     );
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(
//         'scheduledEpoch', scheduledDateTime.millisecondsSinceEpoch);

//     setState(() {
//       isNotificationSet = true;
//       selectedTime = null;
//     });
//     _savePreferences();
//   }

//   void _cancelNotification() async {
//     await NotificationService.cancelNotification();
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('scheduledEpoch');
//     setState(() {
//       isNotificationSet = false;
//       selectedTime = null;
//       selectedInterval = null;
//     });
//     _savePreferences();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Notification cancelled.")),
//     );
//   }

//   Widget _buildTimeIntervalSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(bottom: 12.0),
//           child: Text(
//             "⏰ Time Interval",
//             style: TextStyle(
//               fontFamily: 'PressStart2P',
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.white,
//               width: 3,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: DropdownButtonFormField<int>(
//             dropdownColor: widget.color,
//             value: selectedInterval,
//             hint: const Text(
//               "Select Interval",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             icon: const Icon(
//               Icons.access_time,
//               color: Colors.white,
//             ),
//             style: const TextStyle(
//               fontFamily: 'PressStart2P',
//               fontSize: 11,
//               color: Colors.white,
//             ),
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.zero,
//               enabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//             ),
//             items: timeIntervals.map((int value) {
//               return DropdownMenuItem<int>(
//                 value: value,
//                 child: Text('$value minutes'),
//               );
//             }).toList(),
//             onChanged: (int? newValue) {
//               setState(() {
//                 selectedInterval = newValue;
//                 selectedTime = null;
//                 isNotificationSet = true;
//               });
//               if (newValue != null) {
//                 _scheduleIntervalNotification(newValue);
//               }
//               _savePreferences();
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNotificationSettings() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(bottom: 12.0),
//           child: Text(
//             "📅 Time Selection",
//             style: TextStyle(
//               fontFamily: 'PressStart2P',
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Center(
//           child: buildRetroButton(
//             "Select Time",
//             getShade(widget.color, 300),
//             _pickTime,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildNotificationDetails() {
//     String message;
//     if (isNotificationSet) {
//       if (selectedTime != null) {
//         message = "Notification set for ${selectedTime!.format(context)}";
//       } else if (selectedInterval != null) {
//         message = "Notification set for $selectedInterval minutes from now.";
//       } else {
//         message = "Please choose a time interval or select a time.";
//       }
//     } else {
//       message = "Please choose a time interval or select a time.";
//     }

//     return Column(
//       children: [
//         Text(
//           message,
//           style: const TextStyle(
//             fontFamily: 'PressStart2P',
//             fontSize: 14,
//             color: Colors.white,
//           ),
//         ),
//         if (isNotificationSet)
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: buildRetroButton(
//               "Cancel Notification",
//               Colors.red,
//               _cancelNotification,
//             ),
//           ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: getShade(widget.color, 600),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Lottie.asset(
//                 'assets/notification.json',
//                 width: 200,
//                 height: 200,
//               ),
//               if (!_notificationsAllowed)
//                 buildRetroButton(
//                   "Allow Notifications",
//                   getShade(widget.color, 300),
//                   _requestNotificationPermission,
//                 )
//               else ...[
//                 _buildNotificationDetails(),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: getShade(widget.color, 800),
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 4,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.white,
//                         blurRadius: 3,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: _buildNotificationSettings(),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: getShade(widget.color, 800),
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 4,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.white,
//                         blurRadius: 3,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: _buildTimeIntervalSelector(),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static const String customChannelId = 'custom_sound_channel_id';

//   static Future<void> init() async {
//     const androidSettings = AndroidInitializationSettings('logo');
//     const initializationSettings = InitializationSettings(
//       android: androidSettings,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         // Handle notification tap if needed.
//       },
//     );

//     const customSoundChannel = AndroidNotificationChannel(
//       customChannelId,
//       'Custom Sound Notifications',
//       description: 'Channel for custom sound notifications',
//       importance: Importance.max,
//       sound: RawResourceAndroidNotificationSound('notification'),
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(customSoundChannel);
//   }

//   static Future<void> scheduleNotification(
//       DateTime scheduledTime, String title, String body) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledTime, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           customChannelId,
//           'Custom Sound Notifications',
//           channelDescription: 'Channel for custom sound notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//           sound: RawResourceAndroidNotificationSound('notification'),
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }

//   static Future<void> cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
