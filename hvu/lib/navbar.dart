import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hvu/logged_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hvu/main.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Insert Profile name'),
            accountEmail: const Text('Insert Profile email'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Patient List'),
            onTap:() {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => LoggedIn()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          MaterialButton(
            onPressed:() {
              User? user = FirebaseAuth.instance.currentUser;
                FirebaseAuth.instance.signOut();
                if(user == null){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
                  }
            },
            color: Colors.deepOrange[200],
            child: Text("Sign out"),
          ),
        ], 
      ),
    );
  }
}
