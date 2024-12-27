import 'package:flutter/material.dart';

class MemosAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MemosAppBar(
      {super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override 
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
