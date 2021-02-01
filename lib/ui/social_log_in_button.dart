import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double buttonRadius;
  final double buttonHeight;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {this.buttonText,
      this.buttonColor,
      this.textColor: Colors.white,
      this.buttonRadius: 16.0,
      this.buttonHeight: 40,
      this.buttonIcon,
      this.onPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(buttonRadius))),
        primary: buttonColor,
        onPrimary: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buttonIcon != null ? buttonIcon : Container(),
          Text(
            buttonText,
            style: TextStyle(color: textColor),
          ),
          buttonIcon != null
              ? Opacity(opacity: 0, child: buttonIcon)
              : Container(),
        ],
      ),
    );
  }
}
