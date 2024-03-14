import 'package:flutter/material.dart';
import 'package:suynl/defaults/defaults.dart';
import 'package:suynl/pages/MainPage.dart';
import 'package:suynl/widgets/appdrawertitle.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  VoidCallback clickDrawer(int index){
    return () {
      setState((){
        indexClicked=index;
        Navigator.pop(context);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Simbanay 1.0',style: (TextStyle(fontWeight: FontWeight.bold)),),
            accountEmail: const Text('REACH (SERIES: ONE)'),
            currentAccountPicture: CircleAvatar(
              radius: 18,
              child: ClipOval(
                child: Image.asset('assets/images/raw_icon.png',
                width: 100,
                height: 100,
                fit:BoxFit.cover),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('assets/images/no-imag.jpg'),
                    fit: BoxFit.cover)
            ),
          ),


          ListTile(
            leading: Icon(
                Defaults.drawerItemIcon[0],
                color: indexClicked ==0 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),
            title: Text(
              Defaults.drawerItemText[0],
              style: TextStyle(color: indexClicked ==0 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),),
            onTap: clickDrawer(0)
          ),
          ListTile(
            leading: Icon(
                Defaults.drawerItemIcon[1],
                color: indexClicked ==1 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),
            title: Text(
              Defaults.drawerItemText[1],
              style: TextStyle(color: indexClicked ==1 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),),
            onTap: clickDrawer(1)
          ),
          Divider(),
          ListTile(
            leading: Icon(
                Defaults.drawerItemIcon[2],
                color: indexClicked ==2 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),
            title: Text(
              Defaults.drawerItemText[2],
              style: TextStyle(color: indexClicked ==2 ? Defaults.drawerItemSelectedColor : Defaults.drawerItemColor),),
            onTap: (){
              setState(() {
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
    );
  }
}

