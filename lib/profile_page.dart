import 'package:flutter/material.dart';
import 'package:metrofood/edit_profile.dart';
import 'package:metrofood/login_page.dart';
import 'package:metrofood/setting_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = 'Metro Food';
  final String userImage =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80';

  @override
  Widget build(BuildContext context) {
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
            const CustomListTile(
              icon: Icons.person,
              title: 'User name',
              subtitle: 'Lê Tuấn Kiệt',
            ),

            // CustomListTile to display Email
            const CustomListTile(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'richie.lorie@example.com',
            ),

            // CustomListTile to display Phone Number
            const CustomListTile(
              icon: Icons.phone,
              title: 'Phone Number',
              subtitle: '+1 555 555 5555',
            ),

            const CustomListTile(
              icon: Icons.location_city,
              title: 'Address',
              subtitle: 'Thu Duc City, Ho Chi Minh City',
            ),

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
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
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
