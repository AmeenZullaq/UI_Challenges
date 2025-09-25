import 'package:flutter/material.dart';

class AnimationLoadingPaage extends StatefulWidget {
  const AnimationLoadingPaage({super.key});

  @override
  State<AnimationLoadingPaage> createState() => _AnimationLoadingPaageState();
}

class _AnimationLoadingPaageState extends State<AnimationLoadingPaage>
    with TickerProviderStateMixin {
  late Animation<double> firstDotAnimation;
  late Animation<double> secondDotAnimation;
  late Animation<double> thirdDotAnimation;
  late AnimationController firstDotController;
  late AnimationController secondDotController;
  late AnimationController thirdDotController;

  @override
  void initState() {
    super.initState();
    firstDotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    secondDotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    thirdDotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    firstDotAnimation =
        Tween<double>(begin: 1, end: 2).animate(firstDotController);
    secondDotAnimation =
        Tween<double>(begin: 1, end: 2).animate(secondDotController);
    thirdDotAnimation =
        Tween<double>(begin: 1, end: 2).animate(thirdDotController);

    firstDotAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          secondDotController.forward();
        }
      },
    );

    secondDotAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          thirdDotController.forward();
        }
      },
    );

    thirdDotAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          firstDotController.reset();
          secondDotController.reset();
          thirdDotController.reset();
          firstDotController.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    firstDotController.dispose();
    secondDotController.dispose();
    thirdDotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sequential Loading Dots'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: firstDotAnimation,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
              SizedBox(width: 10),
              ScaleTransition(
                scale: secondDotAnimation,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
              SizedBox(width: 10),
              ScaleTransition(
                scale: thirdDotAnimation,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            ),
            child: const Text(
              'Start Loading Animation',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              firstDotController.forward();
            },
          ),
        ],
      ),
    );
  }
}
