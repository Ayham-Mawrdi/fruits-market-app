import 'package:flutter/material.dart';
import 'package:fruits_market/core/constant.dart';
import 'package:icons_flutter/icons_flutter.dart';

import 'widgets/listtile_with_border_under.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kMainColor,
        title: const Text(
          'Account Setting',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          ListtileWithBorderUnder(
            icon: MaterialIcons.security,
            title: 'Security',
            onTap: () {
              // Your onTap logic here
            },
          ),
          ListtileWithBorderUnder(
            icon: MaterialIcons.close,
            title: 'Deactivate Account',
            onTap: () {
              // Your onTap logic here
            },
          ),
          ListtileWithBorderUnder(
            icon: MaterialIcons.delete,
            title: 'Delete Account',
            onTap: () {
              // Your onTap logic here
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
