// category_page.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trivia_que_app/Screens/questionpage.dart';
import 'package:trivia_que_app/Screens/service.dart'; // Import QuestionPage here

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> categories = [];
  Map<int, bool> selectedCategories = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    const url = 'https://trivia-questions-api.p.rapidapi.com/fetchCategories';
    var headers = {
      'x-rapidapi-key': APIKEY,
      'x-rapidapi-host': 'trivia-questions-api.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final triviaCategories = List<Map<String, dynamic>>.from(data['triviaCategories']);

        setState(() {
          categories = triviaCategories;
          for (var category in categories) {
            selectedCategories[category['id']] = false;
          }
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching categories: $e')),
      );
    }
  }

  void _navigateToQuestions() {
    final selectedCategoryNames = categories
        .where((category) => selectedCategories[category['id']] == true)
        .map((category) => category['name'])
        .toList();

    if (selectedCategoryNames.length >= 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionPage(selectedCategories: selectedCategoryNames.cast<String>()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least 5 categories!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return SizedBox(
                            height: 50,
                            child: Card(
                              child: Column(
                                children: [
                                  Checkbox(
                                    value: selectedCategories[category['id']],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategories[category['id']] = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(category['name']),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _navigateToQuestions,
                      child: const Text('Start'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
