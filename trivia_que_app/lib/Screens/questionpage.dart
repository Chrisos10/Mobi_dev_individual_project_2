import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trivia_que_app/Screens/options.dart';
import 'package:trivia_que_app/Screens/completed.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:html_unescape/html_unescape.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // List to store fetched questions from the API
  List responseData = [];

  // Index to keep track of the current question
  int currentQuestionIndex = 0;

  // Selected option for the current question
  String? selectedOption;

  // Timer for handling the countdown for each question
  late Timer _timer;

  // Countdown seconds remaining for the current question
  int _secondsRemaining = 15;

  // List of shuffled options for the current question
  List<String> shuffledOptions = [];

  // Counters for correct and wrong answers
  int correctAnswers = 0;
  int wrongAnswers = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
    startTimer();
  }

  // Fetches questions from the API and filters them for validity
  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse('https://opentdb.com/api.php?amount=10'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['results'];

        // Filter out invalid questions (ensure they have options and a correct answer)
        final filteredData = data.where((question) {
          final incorrectAnswers = question['incorrect_answers'];
          final correctAnswer = question['correct_answer'];
          return incorrectAnswers != null &&
              incorrectAnswers is List &&
              correctAnswer != null &&
              correctAnswer is String &&
              incorrectAnswers.isNotEmpty;
        }).toList();

        setState(() {
          responseData = filteredData;
          if (responseData.isNotEmpty) {
            updateShuffledOptions();
          }
        });
      } else {
        throw Exception('Failed to load questions.');
      }
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
                  // Background container for the question display area
                  Container(
                    height: 240,
                    width: 390,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 106, 103, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Container to display the current question and question number
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
                            // Display the current question number and total number of questions
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${currentQuestionIndex + 1}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${responseData.length}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Question ${currentQuestionIndex + 1}/${responseData.length}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                            const SizedBox(height: 25),
                            // Display the question text
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  responseData.isNotEmpty
                                      ? decodeHtml(responseData[currentQuestionIndex]['question'] ?? 'No question available')
                                      : 'No question available',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Countdown timer display
                  Positioned(
                    bottom: 210,
                    left: 140,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          _secondsRemaining.toString(),
                          style: const TextStyle(
                              color: Colors.indigo, fontSize: 24),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            // List of answer options
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: responseData.isNotEmpty
                      ? shuffledOptions.map((option) {
                          return OptionsPage(
                            option: decodeHtml(option),
                            isSelected: selectedOption == option,
                            onTap: () {
                              setState(() {
                                selectedOption = option;
                              });
                              checkAnswer(option);
                            },
                          );
                        }).toList()
                      : [],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Button to navigate to the next question
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Checks if the selected answer is correct
  void checkAnswer(String option) {
    final correctAnswer = responseData[currentQuestionIndex]['correct_answer'];
    if (option == correctAnswer) {
      correctAnswers++;
    } else {
      wrongAnswers++;
    }
  }

  // Proceeds to the next question or ends the quiz if all questions are answered
  void nextQuestion() {
    if (currentQuestionIndex == responseData.length - 1) {
      navigateToCompleted();
    } else {
      setState(() {
        currentQuestionIndex++;
        updateShuffledOptions();
        _secondsRemaining = 15;
        selectedOption = null;
      });
    }
  }

  // Navigates to the completed screen with quiz results
  void navigateToCompleted() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Completed(
          correctAnswers: correctAnswers,
          wrongAnswers: wrongAnswers,
          totalQuestions: responseData.length,
        ),
      ),
    );
  }

  // Updates the list of shuffled options for the current question
  void updateShuffledOptions() {
    if (responseData.isNotEmpty) {
      final currentQuestion = responseData[currentQuestionIndex];
      final questionType = currentQuestion['type'];

      if (questionType == 'multiple') {
        setState(() {
          shuffledOptions = shuffleOptions([
            currentQuestion['correct_answer'],
            ...currentQuestion['incorrect_answers'].map((e) => e.toString())
          ]);
        });
      } else if (questionType == 'boolean') {
        setState(() {
          shuffledOptions = ['True', 'False'];
        });
      } else {
        setState(() {
          shuffledOptions = [];
        });
      }
    }
  }

  // Shuffles the list of options to randomize their order
  List<String> shuffleOptions(List<String> options) {
    final shuffled = List<String>.from(options);
    shuffled.shuffle();
    return shuffled;
  }

  // Starts a countdown timer for each question
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--; // Decrement the timer
        });
      } else {
        nextQuestion(); // Automatically move to the next question when time is up
      }
    });
  }

  // Decodes HTML entities in a string
  String decodeHtml(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }
}
