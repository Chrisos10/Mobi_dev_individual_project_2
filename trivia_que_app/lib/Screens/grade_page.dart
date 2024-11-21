import 'package:flutter/material.dart';

class GradePage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final List questions;

  const GradePage({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Grade')),
      body: Column(
        children: [
          Text('You got $correctAnswers out of $totalQuestions correct!'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return ListTile(
                title: Text(question['question']),
                subtitle: Text('Correct Answer: ${question['correct_answer']}'),
              );
            },
          ),
          ElevatedButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: Text('Go Home'),
          ),
        ],
      ),
    );
  }
}
