import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  final String buttonText;
  final Color color;

  const StatusButton(this.buttonText, this.color);

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surface),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
    );
  }
}
