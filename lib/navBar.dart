import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginform/colors.dart';
import 'package:http/http.dart' as http;

import 'loginScreen.dart';

class NavBar extends StatefulWidget {
  final Map<String, dynamic> user;

  NavBar({required this.user});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late String name;
  late String email;
  void initState() {
    super.initState();
    name = widget.user['user']['name'];
    email = widget.user['user']['email'];
  }

  Future<void> logout() async {
    try {
      final response = await http.get(
        'http://localhost:3000/logout',
      );
      if (response.statusCode == 200) {
        final Message = json.decode(response.body)['success'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Message),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 253, 244, 218),
      width: MediaQuery.of(context).size.width * 0.70,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              name ?? 'User name',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            accountEmail: Text(
              email ?? 'User email',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            currentAccountPicture: CircleAvatar(
              child: Image.asset(
                "assets/user.png",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  "assets/profilebg.jpeg",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.dstATop,
                ),
              ),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: primaryColor,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("favorite");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/shopping-bag.png"),
              color: primaryColor,
            ),
            title: Text(
              "Orders",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("Orders");
              print(widget.user);
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/address.png"),
              color: primaryColor,
            ),
            title: Text(
              "Address",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("Address");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/bell.png"),
              color: primaryColor,
            ),
            title: Text(
              "Notification",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("notification");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/help.png"),
              color: primaryColor,
            ),
            title: Text(
              "Help",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("help");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/information-point.png"),
              color: primaryColor,
            ),
            title: Text(
              "About",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("About");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/star.png"),
              color: primaryColor,
            ),
            title: Text(
              "Rate Us",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("Rate");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/phone-book.png"),
              color: primaryColor,
            ),
            title: Text(
              "Contact Book",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              print("Contact Book");
            },
          ),
          ListTile(
            leading: ImageIcon(
              AssetImage("drawerIcons/logout.png"),
              color: primaryColor,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }
}
