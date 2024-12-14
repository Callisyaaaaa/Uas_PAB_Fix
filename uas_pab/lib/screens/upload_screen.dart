import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController(); // Controller untuk Ingredients
  final _stepsController = TextEditingController(); // Controller untuk Steps
  final _caloriesController = TextEditingController();
  File? _image;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk menyimpan data resep
  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      String ingredients = _ingredientsController.text.trim(); // Mengambil data Ingredients
      String steps = _stepsController.text.trim(); // Mengambil data Steps
      String calories = _caloriesController.text.trim();

      print('Nama Resep: $name');
      print('Ingredients: $ingredients');
      print('Steps: $steps');
      print('Kalori: $calories');
      print('Gambar: ${_image?.path}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resep berhasil diunggah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Your Recipe',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade300,
      ),
      body: Container(
        color: Colors.grey.shade100, // Warna latar belakang
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul tambahan
                const Text(
                  "Share Your Delicious and Healthy Recipe!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Fill out the form below to share your creation with others.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),

                // Nama Resep
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Recipe Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text("Enter a catchy name for your recipe."),
                const Divider(),

                // Ingredients
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _ingredientsController, // Menggunakan controller yang berbeda
                    decoration: const InputDecoration(
                      labelText: 'Ingredients',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 4),
                const Text("List all the ingredients required."),
                const Divider(),

                // Steps
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _stepsController, // Menggunakan controller yang berbeda
                    decoration: const InputDecoration(
                      labelText: 'Steps',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(height: 4),
                const Text("Describe how to prepare the recipe step by step."),
                const Divider(),

                // Kalori
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _caloriesController,
                    decoration: const InputDecoration(
                      labelText: 'Calories',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 4),
                const Text("Provide the calorie count for this recipe."),
                const Divider(),

                // Pilih Gambar
                const Text(
                  "Upload an Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: _image == null
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Click here to upload an image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol Simpan
                ElevatedButton(
                  onPressed: _saveRecipe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Share My Recipe',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Teks inspiratif
                const Center(
                  child: Text(
                    "“Cooking is an art, share your masterpiece!”",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
