import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;

  bool get initialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notification',
        channelDescription: 'Daily Notification',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('notification'),
      ),
      iOS: DarwinNotificationDetails(
        sound: 'assets/notification.mp3',
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(),
    );
  }
}

class TestNotification extends StatelessWidget {
  const TestNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Test Notification'),
          onPressed: () {
            NotiService().showNotification(
              title: 'Test Notification',
              body: 'This is a test notification',
            );
          },
        ),
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:practice_app/page/home_page.dart';

// // void main() {
// //   NotiService().initNotification();
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: TestNotification(),
// //     );
// //   }
// // }

// import 'dart:async';

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:circular_reveal_animation/circular_reveal_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: AppTheme.get(isLight: true),
//       darkTheme: AppTheme.get(isLight: false),
//       home: MyHomePage(title: 'Animated Navigation Bottom Bar'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   final autoSizeGroup = AutoSizeGroup();
//   var _bottomNavIndex = 0;

//   late AnimationController _fabAnimationController;
//   late AnimationController _borderRadiusAnimationController;
//   late Animation<double> fabAnimation;
//   late Animation<double> borderRadiusAnimation;
//   late CurvedAnimation fabCurve;
//   late CurvedAnimation borderRadiusCurve;
//   late AnimationController _hideBottomBarAnimationController;

//   final iconList = <IconData>[
//     Icons.brightness_5,
//     Icons.brightness_4,
//     Icons.brightness_6,
//     Icons.brightness_7,
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _fabAnimationController = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _borderRadiusAnimationController = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     fabCurve = CurvedAnimation(
//       parent: _fabAnimationController,
//       curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
//     );
//     borderRadiusCurve = CurvedAnimation(
//       parent: _borderRadiusAnimationController,
//       curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
//     );

//     fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
//     borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
//       borderRadiusCurve,
//     );

//     _hideBottomBarAnimationController = AnimationController(
//       duration: Duration(milliseconds: 200),
//       vsync: this,
//     );

//     Future.delayed(
//       Duration(seconds: 1),
//       () => _fabAnimationController.forward(),
//     );
//     Future.delayed(
//       Duration(seconds: 1),
//       () => _borderRadiusAnimationController.forward(),
//     );
//   }

//   bool onScrollNotification(ScrollNotification notification) {
//     if (notification is UserScrollNotification &&
//         notification.metrics.axis == Axis.vertical) {
//       switch (notification.direction) {
//         case ScrollDirection.forward:
//           _hideBottomBarAnimationController.reverse();
//           _fabAnimationController.forward(from: 0);
//           break;
//         case ScrollDirection.reverse:
//           _hideBottomBarAnimationController.forward();
//           _fabAnimationController.reverse(from: 1);
//           break;
//         case ScrollDirection.idle:
//           break;
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).extension<CustomColorsTheme>()!;
//     return Scaffold(
//       extendBody: true,
//       appBar: AppBar(
//         title: Text(
//           widget.title,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: onScrollNotification,
//         child: NavigationScreen(iconList[_bottomNavIndex]),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(
//           Icons.brightness_3,
//           color: AppTheme.colorGray,
//         ),
//         onPressed: () {
//           _fabAnimationController.reset();
//           _borderRadiusAnimationController.reset();
//           _borderRadiusAnimationController.forward();
//           _fabAnimationController.forward();
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: AnimatedBottomNavigationBar.builder(
//         itemCount: iconList.length,
//         tabBuilder: (int index, bool isActive) {
//           final color = isActive
//               ? colors.activeNavigationBarColor
//               : colors.notActiveNavigationBarColor;
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 iconList[index],
//                 size: 24,
//                 color: color,
//               ),
//               const SizedBox(height: 4),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: AutoSizeText(
//                   "brightness $index",
//                   maxLines: 1,
//                   style: TextStyle(color: color),
//                   group: autoSizeGroup,
//                 ),
//               )
//             ],
//           );
//         },
//         backgroundColor: colors.bottomNavigationBarBackgroundColor,
//         activeIndex: _bottomNavIndex,
//         splashColor: colors.activeNavigationBarColor,
//         notchAndCornersAnimation: borderRadiusAnimation,
//         splashSpeedInMilliseconds: 300,
//         notchSmoothness: NotchSmoothness.defaultEdge,
//         gapLocation: GapLocation.center,
//         leftCornerRadius: 32,
//         rightCornerRadius: 32,
//         onTap: (index) => setState(() => _bottomNavIndex = index),
//         hideAnimationController: _hideBottomBarAnimationController,
//         shadow: BoxShadow(
//           offset: Offset(0, 1),
//           blurRadius: 12,
//           spreadRadius: 0.5,
//           color: colors.activeNavigationBarColor,
//         ),
//       ),
//     );
//   }
// }

// class NavigationScreen extends StatefulWidget {
//   final IconData iconData;

//   NavigationScreen(this.iconData) : super();

//   @override
//   _NavigationScreenState createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> animation;

//   @override
//   void didUpdateWidget(NavigationScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.iconData != widget.iconData) {
//       _startAnimation();
//     }
//   }

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1000),
//     );
//     animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//     super.initState();
//   }

//   _startAnimation() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1000),
//     );
//     animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).extension<CustomColorsTheme>()!;
//     return Container(
//       color: Theme.of(context).colorScheme.background,
//       child: ListView(
//         children: [
//           SizedBox(height: 64),
//           Center(
//             child: CircularRevealAnimation(
//               animation: animation,
//               centerOffset: Offset(80, 80),
//               maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
//               child: Icon(
//                 widget.iconData,
//                 color: colors.activeNavigationBarColor,
//                 size: 160,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AppTheme {
//   static HexColor colorOrange = HexColor('#FFA400');
//   static HexColor colorGray = HexColor('#373A36');

//   static ThemeData get({required bool isLight}) {
//     final base = isLight ? ThemeData.light() : ThemeData.dark();
//     return base.copyWith(
//       extensions: [
//         CustomColorsTheme(
//           colorLabelColor: isLight ? Colors.grey : const Color(0xFF7A7FB0),
//           bottomNavigationBarBackgroundColor: isLight ? Colors.blue : colorGray,
//           activeNavigationBarColor: isLight ? Colors.yellow : colorOrange,
//           notActiveNavigationBarColor: Colors.white,
//           shadowNavigationBarColor: isLight ? Colors.blue : colorOrange,
//         )
//       ],
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: isLight ? Colors.yellow : colorOrange,
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: isLight ? Colors.blue : colorGray,
//       ),
//       colorScheme: base.colorScheme.copyWith(
//         surface: isLight ? Colors.blue : colorGray,
//         background: isLight ? Colors.white : colorGray,
//       ),
//     );
//   }
// }

// class HexColor extends Color {
//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll('#', '');
//     if (hexColor.length == 6) {
//       hexColor = 'FF' + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }

// @immutable
// class CustomColorsTheme extends ThemeExtension<CustomColorsTheme> {
//   const CustomColorsTheme({
//     required this.bottomNavigationBarBackgroundColor,
//     required this.colorLabelColor,
//     required this.activeNavigationBarColor,
//     required this.notActiveNavigationBarColor,
//     required this.shadowNavigationBarColor,
//   });

//   final Color bottomNavigationBarBackgroundColor;
//   final Color colorLabelColor;
//   final Color activeNavigationBarColor;
//   final Color notActiveNavigationBarColor;
//   final Color shadowNavigationBarColor;

//   @override
//   CustomColorsTheme copyWith({
//     Color? bottomNavigationBarBackgroundColor,
//     Color? colorLabelColor,
//     Color? activeNavigationBarColor,
//     Color? notActiveNavigationBarColor,
//     Color? shadowNavigationBarColor,
//   }) {
//     return CustomColorsTheme(
//       bottomNavigationBarBackgroundColor: bottomNavigationBarBackgroundColor ??
//           this.bottomNavigationBarBackgroundColor,
//       colorLabelColor: colorLabelColor ?? this.colorLabelColor,
//       activeNavigationBarColor:
//           activeNavigationBarColor ?? this.activeNavigationBarColor,
//       notActiveNavigationBarColor:
//           notActiveNavigationBarColor ?? this.notActiveNavigationBarColor,
//       shadowNavigationBarColor:
//           shadowNavigationBarColor ?? this.shadowNavigationBarColor,
//     );
//   }

//   @override
//   CustomColorsTheme lerp(
//     ThemeExtension<CustomColorsTheme>? other,
//     double t,
//   ) {
//     if (other is! CustomColorsTheme) {
//       return this;
//     }
//     return CustomColorsTheme(
//       bottomNavigationBarBackgroundColor: Color.lerp(
//               bottomNavigationBarBackgroundColor,
//               other.bottomNavigationBarBackgroundColor,
//               t) ??
//           bottomNavigationBarBackgroundColor,
//       colorLabelColor: Color.lerp(colorLabelColor, other.colorLabelColor, t) ??
//           colorLabelColor,
//       activeNavigationBarColor: Color.lerp(
//               activeNavigationBarColor, other.activeNavigationBarColor, t) ??
//           activeNavigationBarColor,
//       notActiveNavigationBarColor: Color.lerp(notActiveNavigationBarColor,
//               other.notActiveNavigationBarColor, t) ??
//           notActiveNavigationBarColor,
//       shadowNavigationBarColor: Color.lerp(
//               shadowNavigationBarColor, other.shadowNavigationBarColor, t) ??
//           shadowNavigationBarColor,
//     );
//   }
// }
