import 'package:flutter/material.dart';
import 'package:uas_pab/models/recipe.dart';

class DetailScreen extends StatelessWidget {
  final Recipe varRecipe;
  const DetailScreen({super.key, required this.varRecipe});

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
                        varRecipe.imageAsset,
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
                    Text(
                      varRecipe.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                            '${varRecipe.cookingTime}',
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
                            '${varRecipe.calories}',
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
                            '${varRecipe.servings}',
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
                      varRecipe.description,
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
                        itemCount: varRecipe.ingredients.length,
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
                                    varRecipe.ingredients[index],
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
                        itemCount: varRecipe.steps.length,
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
                                    varRecipe.steps[index],
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
            ],
          ),
        ),
      ),
    );
  }
}
