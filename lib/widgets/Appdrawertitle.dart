import 'package:flutter/material.dart';
import 'package:suynl/defaults/defaults.dart';

class AppDrawerTitle extends StatelessWidget {
  const AppDrawerTitle({
    Key? key,
    required this.index,
    required this.onTap,
    }) : super(key: key);

  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
          Defaults.drawerItemIcon[index],
          color: index ==index ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),
      title: Text(
        Defaults.drawerItemText[index],
        style: TextStyle(color: index ==index ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),),
    );
  }
}
