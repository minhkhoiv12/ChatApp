import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:chatapp/authentication/login_screen.dart';
import 'package:chatapp/authentication/opt_screen.dart';
import 'package:chatapp/authentication/user_information_screen.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/main_screen/home_screen.dart';
import 'package:chatapp/providers/authentication_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: MyApp(savedThemeMode: savedThemeMode),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.savedThemeMode});
  final AdaptiveThemeMode? savedThemeMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: Constants.loginScreen,
       // home: const UserInformationScreen(),
       routes: {
         //Constants.landingScreen: (context) => const LandingScreen(),
          Constants.loginScreen: (context) => const LoginScreen(),
          Constants.otpScreen: (context) => const OTPScreen(),
          Constants.userInformationScreen: (context) =>
              const UserInformationScreen(),
          Constants.homeScreen: (context) => const HomeScreen(),
         // Constants.profileScreen: (context) => const ProfileScreen(),
         // Constants.friendsScreen: (context) => const FriendsScreen(),
          // Constants.friendRequestsScreen: (context) =>
          //     const FriendRequestScreen(),
        //  Constants.chatScreen: (context) => const ChatScreen(),
          // Constants.groupSettingsScreen: (context) =>
          //     const GroupSettingsScreen(),
          // Constants.groupInformationScreen: (context) =>
          //     const GroupInformationScreen(),
        },
      ),
    );
  }
}

