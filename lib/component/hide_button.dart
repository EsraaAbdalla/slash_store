// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

class HideButton extends StatelessWidget {
  const HideButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
        style: TextButton.styleFrom(
            minimumSize: const Size(300, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  25), // Set the desired circular border radius
            ),
            backgroundColor: Color.lerp(
                const Color(0XFFFCC8FED), const Color(0XFFF6B50F6), 0.5)),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Hide Description',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
