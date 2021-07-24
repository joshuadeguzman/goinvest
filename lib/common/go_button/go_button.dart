import 'package:flutter/material.dart';

class GoButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const GoButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: onPressed,
        child: Container(
          width: 240,
          height: 48,
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
