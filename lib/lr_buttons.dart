import 'package:flutter/material.dart';

class LoginRegistrationButton extends StatelessWidget {
  final Function onPressed;
  final String displayText;
  final Color buttonColor;
  LoginRegistrationButton({this.onPressed,this.displayText,this.buttonColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      child: Material(
        elevation: 6.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(displayText,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
