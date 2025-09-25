import 'package:flutter/material.dart';

class AnimationLoadingPaage extends StatefulWidget {
  const AnimationLoadingPaage({super.key});

  @override
  State<AnimationLoadingPaage> createState() => _AnimationLoadingPaageState();
}

class _AnimationLoadingPaageState extends State<AnimationLoadingPaage>
    with TickerProviderStateMixin {
  late Animation<double> firstScaleDotAnimation;
  late Animation<double> secondScaleDotAnimation;
  late Animation<double> thirdScaleDotAnimation;
  late Animation<double> firstFadeDotAnimation;
  late Animation<double> secondFadeDotAnimation;
  late Animation<double> thirdFadeDotAnimation;
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
    firstFadeDotAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(firstDotController);
    secondFadeDotAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(secondDotController);
    thirdFadeDotAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(thirdDotController);
    firstScaleDotAnimation =
        Tween<double>(begin: 1, end: 2).animate(firstDotController);
    secondScaleDotAnimation =
        Tween<double>(begin: 1, end: 2).animate(secondDotController);
    thirdScaleDotAnimation =
        Tween<double>(begin: 1, end: 2).animate(thirdDotController);

    firstScaleDotAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          secondDotController.forward();
        }
      },
    );

    secondScaleDotAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          thirdDotController.forward();
        }
      },
    );

    thirdScaleDotAnimation.addStatusListener(
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
                scale: firstScaleDotAnimation,
                child: FadeTransition(
                  opacity: firstFadeDotAnimation,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 10),
              ScaleTransition(
                scale: secondScaleDotAnimation,
                child: FadeTransition(
                  opacity: secondFadeDotAnimation,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 10),
              ScaleTransition(
                scale: thirdScaleDotAnimation,
                child: FadeTransition(
                  opacity: thirdFadeDotAnimation,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.blue,
                  ),
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
