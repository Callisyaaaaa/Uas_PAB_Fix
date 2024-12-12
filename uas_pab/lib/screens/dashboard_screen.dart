import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_pab/data/recipe_data.dart';
import 'package:uas_pab/data/user_data.dart';
import 'package:uas_pab/models/recipe.dart';
import 'package:uas_pab/models/user.dart';
// import 'package:uas_pab/screens/bookmark_screen.dart';
import 'package:uas_pab/screens/detail_screen.dart';
import 'package:uas_pab/screens/profile_screen.dart';
// import 'package:uas_pab/screens/upload_screen.dart';

// Fungsi untuk mendapatkan user yang sedang login
Future<User?> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email =
      prefs.getString('email'); // Ambil email dari SharedPreferences

  // Cari user berdasarkan email secara manual
  var matchingUsers = userList.where((user) => user.email == email);
  return matchingUsers.isNotEmpty ? matchingUsers.first : null;
}

Future<void> debugPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Email: ${prefs.getString('email')}'); // Debugging
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchController = TextEditingController();
  List<Recipe> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipeList; // Awalnya tampilkan semua resep
    searchController.addListener(() {
      filterRecipes();
    });
    debugPreferences(); // Untuk debugging
  }

  void filterRecipes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = recipeList.where((recipe) {
        return recipe.name.toLowerCase().contains(query) ||
            recipe.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FutureBuilder<User?>(
                        future: getCurrentUser(),
                        builder: (context, snapshot) {
                          String userName = 'Guest';
                          if (snapshot.hasData) {
                            userName = snapshot.data!.name;
                          }
                          return Column(
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
                              const SizedBox(height: 10),

                              // Search Field
                              TextField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16), // Jarak antar header dan avatar
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // Lingkaran putih
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('images/regina.jpg'),
                          radius: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Explore New Dishes Section
              const Text(
                "Explore New Healthy Dishes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),

              // GridView Section (Filtered Data)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                padding: const EdgeInsets.all(8),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  Recipe varRecipe = filteredRecipes[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(varRecipe: varRecipe),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.all(6),
                      elevation: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.asset(
                                varRecipe.imageAsset,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Recipe Name
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8),
                            child: Text(
                              varRecipe.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // Calorie Count
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 8),
                            child: Text(
                              'Calories: ${varRecipe.calories}',
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
