import 'package:flutter/material.dart';
import 'package:thunder_chat/chat_screen.dart';
import 'package:thunder_chat/login_screen.dart';
import 'package:thunder_chat/registration_screen.dart';
import 'welcome_screen.dart';
void main() {
  runApp(ThunderChat());
}

class ThunderChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color.fromRGBO(69, 209, 253, 1),
        accentColor: Color.fromRGBO(7, 91, 154, 1),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        ChatScreen.id : (context) => ChatScreen()
      },
    );
  }
}
