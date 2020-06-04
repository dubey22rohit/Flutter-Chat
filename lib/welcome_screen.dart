import 'package:flutter/material.dart';
import 'package:thunder_chat/login_screen.dart';
import 'package:thunder_chat/lr_buttons.dart';
import 'package:thunder_chat/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController controller; //Parent
  // Animation animation;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(
  //     duration: Duration(seconds: 10),
  //     vsync: this,
  //   );
  //   animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

  //   controller.forward();
  //   animation.addStatusListener((status) {
  //     if (animation.isCompleted) {
  //       controller.reverse(from: 1.0);
  //     } else if (animation.isDismissed) {
  //       controller.forward();
  //     }
  //   });
  //   controller.addListener(() {
  //     setState(() {

  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 54.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 100.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 350),
                  text: [
                    'Thunder Chat',
                  ],
                  textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                  totalRepeatCount: 1,
                  repeatForever: true,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            LoginRegistrationButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              displayText: 'Login',
              buttonColor: Theme.of(context).primaryColor,
            ),
            LoginRegistrationButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              displayText: 'Register',
              buttonColor: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
