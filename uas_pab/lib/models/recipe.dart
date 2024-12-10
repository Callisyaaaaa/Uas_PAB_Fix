class Recipe {
  final String name;
  final String description;
  final String imageAsset;
  final List<String> ingredients;
  final List<String> steps;
  final String cookingTime;
  final String calories;
  final String servings;
  final String difficulty;

  Recipe({
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
    required this.calories,
    required this.servings,
    required this.difficulty,
  });
}
