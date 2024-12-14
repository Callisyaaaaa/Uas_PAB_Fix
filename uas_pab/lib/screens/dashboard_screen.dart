import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_pab/models/user.dart'; // Import user model
import 'package:uas_pab/data/user_data.dart'; // Import user data

Future<User?> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username'); // Ambil nama dari SharedPreferences

  // Cari user berdasarkan nama yang disimpan
  var matchingUsers = userList.where((user) => user.name == username);
  return matchingUsers.isNotEmpty ? matchingUsers.first : null;
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<User?>(
        future: getCurrentUser(), // Ambil user yang login
        builder: (context, snapshot) {
          String userName = 'Guest';
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              userName = snapshot.data!.name; // Menggunakan nama user
            }
          }

          return SafeArea(
            child: Column(
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, $userName!',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Discover, Cook, and Enjoy Healthy Meals!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Other sections of the dashboard
              ],
            ),
          );
        },
      ),
    );
  }
}
