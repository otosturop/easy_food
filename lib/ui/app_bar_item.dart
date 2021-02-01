import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  final VoidCallback onPressedBackButton;
  final String pageTitle;
  final Icon actionIcon;

  const AppBarItem(this.onPressedBackButton, this.pageTitle, this.actionIcon);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 2.0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
            color: Theme.of(context).colorScheme.primaryVariant),
        onPressed: onPressedBackButton,
      ),
      title: Text(pageTitle,
          style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 20.0,
              color: Theme.of(context).colorScheme.primaryVariant)),
      actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {},
        ),
      ],
    );
  }
}
