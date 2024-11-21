import 'dart:async'; // For Timer
import 'dart:convert'; // For jsonDecode
import 'package:flutter/material.dart';
import 'package:trivia_que_app/Screens/grade_page.dart';
import 'package:trivia_que_app/Screens/options.dart';
import 'package:trivia_que_app/Screens/completed.dart';
import 'package:http/http.dart' as http;

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List responseData = [];
  int number = 0;
  late Timer _timer;
  int _secondRemaining = 15;
  List<String> shuffledOptions = [];

  Future<void> api() async {
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      setState(() {
        responseData = data;
        updateShuffleOption();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    api();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 420,
              width: 390,
              child: Stack(
                children: [
                  Container(
                    height: 240,
                    width: 390,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 22,
                    child: Container(
                      height: 170,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '05',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '07',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Center(
                              child: Text(
                                'Question 3/10',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Text(responseData.isNotEmpty
                                ? responseData[number]['question']
                                : ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 210,
                    left: 140,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          _secondRemaining.toString(),
                          style: const TextStyle(color: Colors.indigo, fontSize: 12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: responseData.isNotEmpty &&
                      responseData[number]['incorrect_answers'] != null
                  ? shuffledOptions.map((option) {
                      return OptionsPage(option: option.toString());
                    }).toList()
                  : [],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                onPressed: nextQuestion,
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextQuestion() {
    if (number == 9) {
      completed();
    } else {
      setState(() {
        number++;
        updateShuffleOption();
        _secondRemaining = 15;
      });
    }
  }

  void completed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Completed()),
    );
  }

  void updateShuffleOption() {
    setState(() {
      shuffledOptions = shuffleOption([
        responseData[number]['correct_answer'],
        ...responseData[number]['incorrect_answers'] as List
      ]);
    });
  }

  List<String> shuffleOption(List<String> options) {
    List<String> shuffledOptions = List.from(options);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondRemaining > 0) {
        setState(() {
          _secondRemaining--;
        });
      } else {
        nextQuestion();
      }
    });
  }
}
