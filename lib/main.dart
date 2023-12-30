import 'package:alarm_app/InfoLerning.dart/PagLerning.dart';
import 'package:alarm_app/Me.dart';
import 'package:alarm_app/Screen/PagSpeshles.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:alarm_app/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initializeNotification();
  runApp(MyApp());
}

PageController controllers = PageController();
PageController controllerslearning = PageController();

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    getBool();
    getAllProdDetails();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Alarts',
      theme: ThemeData(
        textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
        primaryColor: Color(0xFF202328),
        backgroundColor: Color(0xFF12171D),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF63CF93)),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: SplashPage(),
      ),
      routes: {
        "Splash": (context) => LearningPage(),
        "Me": (context) => Myinfopro(),
      },
    );
  }
}
