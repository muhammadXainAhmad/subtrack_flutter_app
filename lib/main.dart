import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/firebase_options.dart';
import 'package:subtrack/providers/authentication_provider.dart';
import 'package:subtrack/providers/bottom_nav_provider.dart';
import 'package:subtrack/providers/category_chart_provider.dart';
import 'package:subtrack/providers/notification_provider.dart';
import 'package:subtrack/providers/segmented_btn_provider.dart';
import 'package:subtrack/providers/subscription_provider.dart';
import 'package:subtrack/providers/user_provider.dart';
import 'package:subtrack/screens/landing_screen.dart';
import 'package:subtrack/screens/main_screen.dart';
import 'package:subtrack/utils/utils.dart';

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print("TITLE: ${message.notification!.title.toString()}");
    print("BODY: ${message.notification!.body.toString()}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // uploadSubscriptionData();
  // updateSubscriptionIcons();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
          create:
              (context) =>
                  SubscriptionProvider()
                    ..fetchActiveSubNumbers()
                    ..calculateBills(),
        ),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => SegmentedBtnProvider()),
        ChangeNotifierProvider(
          create: (context) => CategoryChartProvider()..fetchCategoryData(),
        ),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SubTrack',
      themeMode: ThemeMode.system,
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<UserProvider>().refreshUser();
            });
            return MainScreen();
          } else {
            return const LandingScreen();
          }
        },
      ),
    );
  }
}
