import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_pab/models/recipe.dart';
import 'package:uas_pab/screens/make_screen.dart';

class DetailScreen extends StatefulWidget {
  final Recipe varRecipe;
  const DetailScreen({super.key, required this.varRecipe});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];
    setState(() {
      _isFavorite = favoriteRecipes.contains(widget.varRecipe.name);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];

    setState(() {
      if (_isFavorite) {
        favoriteRecipes.remove(widget.varRecipe.name);
        _isFavorite = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.varRecipe.name} removed from bookmark')));
      } else {
        favoriteRecipes.add(widget.varRecipe.name);
        _isFavorite = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${widget.varRecipe.name} added to bookmark')));
      }
    });

    await prefs.setStringList('favoriteRecipes', favoriteRecipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian Atas
              Stack(
                children: [
                  // Gambar Utama
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.varRecipe.imageAsset,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                  ),
                  // Tombol Back
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
              // Judul
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Judul
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.varRecipe.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: _toggleFavorite,
                            icon: Icon(_isFavorite
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                            color: _isFavorite ? Colors.green : null),
                      ],
                    ),
                    // Info
                    Padding(
                      padding: const EdgeInsets.only(left: 1, top: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.schedule, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text(
                            'Cooking Time:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.varRecipe.cookingTime}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1, top: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Colors.orange),
                          const SizedBox(width: 8),
                          const Text(
                            'Calories:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.varRecipe.calories}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 1, top: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.restaurant, color: Colors.grey),
                          const SizedBox(width: 8),
                          const Text(
                            'Servings:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.varRecipe.servings}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.green, thickness: 1),
                    const SizedBox(height: 16),
                    // Deskripsi
                    Text(
                      widget.varRecipe.description,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.green, thickness: 1),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              // Ingredients
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.varRecipe.ingredients.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.add,
                                    color: Colors.grey, size: 15),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.varRecipe.ingredients[index],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(color: Colors.green, thickness: 1),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Steps
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Steps',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: widget.varRecipe.steps.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.check,
                                    color: Colors.green, size: 15),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    widget.varRecipe.steps[index],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeScreen(
                                recipeName: '',
                                steps: [],
                              )),
                    );
                  },
                  child: const Text(
                    'Cook It Now !',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
