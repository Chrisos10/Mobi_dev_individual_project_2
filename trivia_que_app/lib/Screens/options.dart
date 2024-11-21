import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  final String option = 'Option Text';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 48, width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 3, color: Colors.red)
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(option, style: const TextStyle(fontWeight: FontWeight.bold),),
                  Radio(value: option, groupValue: 2, onChanged: (val){})
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}