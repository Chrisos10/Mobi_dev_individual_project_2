import 'package:flutter/material.dart';
import 'package:trivia_que_app/Screens/homepage.dart';

class Completed extends StatelessWidget {
  // Number of correct answers
  final int correctAnswers;

  // Number of wrong answers
  final int wrongAnswers;

  // Total number of questions
  final int totalQuestions;

  const Completed({
    super.key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 521,
            width: 400,
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: 410,
                  decoration: BoxDecoration(
                    color:  const Color.fromRGBO(0, 106, 103, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    // Circle avatar for displaying the user's score
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.white.withOpacity(.3),
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.4),
                        radius: 71,
                        child: CircleAvatar(
                          radius: 68,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Your score',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                                RichText(
                                  // Displays the calculated score as a percentage
                                  text: TextSpan(
                                    text:
                                        '${correctAnswers * 10}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: ' %',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Container for detailed score breakdown
                Positioned(
                  bottom: 60,
                  left: 22,
                  child: Container(
                    height: 190,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '$correctAnswers',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text('Correct'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '$wrongAnswers', // Display wrong answers count
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text('Wrong'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '$totalQuestions',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text('Total Questions'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Action buttons for replay, review, and share
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Button to replay the quiz
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 20,
                          child: Center(
                            child: Icon(
                              Icons.refresh,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Play again',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  // Button to review answers
                  const Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Center(
                          child: Icon(
                            Icons.visibility_rounded,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Review Answer',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  // Button to share results
                  const Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Center(
                          child: Icon(
                            Icons.share,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Share',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
