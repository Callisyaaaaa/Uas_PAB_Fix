import 'dart:async';
import 'package:flutter/material.dart';

class AfterStepsScreen extends StatefulWidget {
  const AfterStepsScreen({super.key});

  @override
  _AfterStepsScreenState createState() => _AfterStepsScreenState();
}

class _AfterStepsScreenState extends State<AfterStepsScreen> {
  List<bool> _starFilled = [false, false, false, false, false];
  int _currentStar = 0;
  bool _showGoodJob = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _animateStars();
  }

  void _animateStars() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_currentStar < 5) {
        setState(() {
          _starFilled[_currentStar] = true;
          _currentStar++;
        });

        // Efek loncat atau melompat (Bounce)
        Future.delayed(Duration(milliseconds: 150), () {
          setState(() {});
        });
      } else {
        timer.cancel();
        _showGoodJobMessage();
      }
    });
  }

  void _showGoodJobMessage() {
    // Setelah animasi bintang selesai, tampilkan tulisan Good Job!
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _showGoodJob = true;
      });
    });

    // Tampilkan tombol "Back to Dashboard" setelah Good Job
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  void _goBackToDashboard() {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.green.shade200,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Bintang
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceOut,  // Menggunakan bounce effect
                    top: _starFilled[index] ? 0 : 30, // Efek loncat
                    child: AnimatedOpacity(
                      opacity: _starFilled[index] ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 60, // Bintang lebih besar
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Animasi untuk Good Job
              AnimatedOpacity(
                opacity: _showGoodJob ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: Text(
                  'Wow even better than mama',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600, // Warna hijau lebih cerah
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Tombol Back to Dashboard dengan animasi
              if (_showButton)
                AnimatedOpacity(
                  opacity: _showButton ? 1.0 : 0.0,
                  duration: const Duration(seconds: 2),
                  child: AnimatedScale(
                    scale: _showButton ? 1.0 : 0.8,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade200,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: _goBackToDashboard,
                        child: const Text(
                          'Back to Dashboard',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
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
