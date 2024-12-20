import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_pab/data/recipe_data.dart';
import 'package:uas_pab/models/recipe.dart';
import 'package:uas_pab/screens/detail_screen.dart';
import 'package:uas_pab/screens/dashboard_screen.dart'; // Pastikan path benar

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Recipe> _favoriteRecipes = [];

  Future<void> _loadFavoriteRecipes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteRecipesNames =
        prefs.getStringList('favoriteRecipes') ?? [];

    setState(() {
      _favoriteRecipes = recipeList
          .where((recipe) => favoriteRecipesNames.contains(recipe.name))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Mengubah tampilan grid menjadi 2 kolom
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                padding: const EdgeInsets.all(8),
                itemCount: _favoriteRecipes.length,
                itemBuilder: (context, index) {
                  Recipe varRecipe = _favoriteRecipes[index];
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
                            padding:
                                const EdgeInsets.only(left: 16, top: 8),
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
                            padding:
                                const EdgeInsets.only(left: 16, bottom: 8),
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