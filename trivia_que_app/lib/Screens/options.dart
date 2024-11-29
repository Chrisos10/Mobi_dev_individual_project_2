import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  // Text to display for the option
  final String option;

  // Indicates if this option is currently selected
  final bool isSelected;

  // Callback triggered when the option is tapped
  final VoidCallback onTap;

  const OptionsPage({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(0, 69, 67, 1).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color.fromRGBO(0, 69, 67, 1),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Displays the option text
            Flexible(
              child: Text(
                option,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 69, 67, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Circle indicator for selection status
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromRGBO(0, 69, 67, 1),
                  width: 2,
                ),
                color: isSelected
                    ? const Color.fromRGBO(0, 69, 67, 1)
                    : Colors.transparent,
              ),
              // Checkmark icon displayed if the option is selected
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
