import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuestionPage extends StatefulWidget {
  final List<String> selectedCategories;

  const QuestionPage({super.key, required this.selectedCategories});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    const url = 'https://trivia-questions-api.p.rapidapi.com/triviaApi';
    var headers = {
      'x-rapidapi-key': '9ede381e89msh2ce120e579a262cp12b6bdjsn43fd3d8f8851',
      'x-rapidapi-host': 'trivia-questions-api.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['triviaQuestions'];
        final filteredQuestions = (data as List)
            .where((q) => widget.selectedCategories.contains(q['category']))
            .toList();

        setState(() {
          questions = List<Map<String, dynamic>>.from(filteredQuestions);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching questions: $e')),
      );
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FinishPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (questions.isEmpty) {
      return Scaffold(
        body: const Center(child: Text('No questions available for the selected categories.')),
      );
    }

    final question = questions[currentQuestionIndex];
    final options = (question['incorrect_answers'] as List<dynamic>)
      ..add(question['correct_answer'])
      ..shuffle();

    return Scaffold(
      appBar: AppBar(title: const Text('Question')),
      body: Column(
        children: [
          Text('Q${currentQuestionIndex + 1}: ${question['question']}'),
          ...options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: _nextQuestion,
            );
          }),
          if (currentQuestionIndex == questions.length - 1)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const FinishPage()),
                );
              },
              child: const Text('Finish'),
            ),
        ],
      ),
    );
  }
}

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Finish'),
        ),
      ),
    );
  }
}
