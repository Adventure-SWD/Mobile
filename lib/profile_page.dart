
import 'package:flutter/material.dart';
import 'package:metrofood/edit_profile.dart';
import 'package:metrofood/login_page.dart';
import 'package:metrofood/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = 'Metro Food';
  late String username = "";
  late String email = "";
  final String userImage =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80';

  @override
  void initState() {
    getInformation();
    super.initState();
  }
  void getInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('userName') ?? "";
      email = prefs.getString('email') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    void _handleLogout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userId');
      Navigator.pushNamedAndRemoveUntil(
          context, '/login-page', ModalRoute.withName('/login-page'));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            // Row to display user name and image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // CustomListTile
            CustomListTile(
              icon: Icons.person,
              title: 'User name',
              subtitle: username,
            ),

            // CustomListTile to display Email
            CustomListTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: email,
            ),

            // CustomListTile to display Phone Number
            // const CustomListTile(
            //   icon: Icons.phone,
            //   title: 'Phone Number',
            //   subtitle: '+1 555 555 5555',
            // ),
            //
            // const CustomListTile(
            //   icon: Icons.location_city,
            //   title: 'Address',
            //   subtitle: 'Thu Duc City, Ho Chi Minh City',
            // ),

            // CustomListTile to display Purchase History
            const CustomListTile(
              icon: Icons.history,
              title: 'Purchase History',
            ),

            CustomListTile(
              icon: Icons.edit,
              title: 'Edit profile',
              onTap: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
            ),

            // CustomListTile to display Settings
            CustomListTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),

            // Log out
             CustomListTile(
              icon: Icons.logout,
              title: 'Log out',
              onTap: () {
                _handleLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}



class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
    );
  }
}
