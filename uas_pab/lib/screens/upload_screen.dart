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
  final _descriptionController = TextEditingController();
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
      // Data yang diisi valid
      String name = _nameController.text.trim();
      String description = _descriptionController.text.trim();
      String calories = _caloriesController.text.trim();

      // Proses simpan (misalnya simpan ke database atau array lokal)
      print('Nama Resep: $name');
      print('Deskripsi: $description');
      print('Kalori: $calories');
      print('Gambar: ${_image?.path}');

      // Reset form setelah berhasil disimpan
      _formKey.currentState?.reset();
      setState(() {
        _image = null;
      });

      // Berikan notifikasi kepada pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resep berhasil diunggah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Your Recipe'),
        backgroundColor: Colors.green.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Resep
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama resep tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //Bahan
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Ingridients',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You Must Fill this Field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Deskripsi Resep
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Steps',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You Must Fill This Field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Kalori
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Kalori',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah kalori tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Kalori harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Pilih Gambar
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file, // Ikon upload
                                size: 48, // Ukuran ikon
                                color: Colors.grey, // Warna ikon
                              ),
                              SizedBox(height: 8), // Jarak antara ikon dan teks
                              Text(
                                'Klik untuk memilih gambar', // Teks
                                style: TextStyle(
                                  fontSize: 16, // Ukuran teks
                                  color: Colors.grey, // Warna teks
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
                    'Unggah Resep',
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
