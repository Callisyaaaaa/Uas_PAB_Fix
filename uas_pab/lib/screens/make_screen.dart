// Import file dart yang diperlukan
import 'package:flutter/material.dart';
//import 'package:uas_pab/models/recipe.dart'; // Pastikan path ini sesuai
//import 'package:uas_pab/data/recipe_data.dart';

class MakeScreen extends StatefulWidget {
  final String recipeName;
  final List<String> steps;

  const MakeScreen({
    super.key,
    required this.recipeName,
    required this.steps,
  });

  @override
  State<MakeScreen> createState() => _MakeScreenState();
}

class _MakeScreenState extends State<MakeScreen> {
  late List<bool> completedSteps;

  @override
  void initState() {
    super.initState();
    completedSteps = List<bool>.filled(widget.steps.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cooking Steps',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.steps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Checkbox untuk melacak status langkah
                        Checkbox(
                          value: completedSteps[index],
                          onChanged: (value) {
                            setState(() {
                              completedSteps[index] = value ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            widget.steps[index],
                            style: TextStyle(
                              fontSize: 16,
                              decoration: completedSteps[index]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (completedSteps.every((step) => step)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Well Done!'),
                          content: Text(
                              'You have completed cooking "${widget.recipeName}"!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all steps first!'),
                      ),
                    );
                  }
                },
                child: const Text('Finish Cooking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
