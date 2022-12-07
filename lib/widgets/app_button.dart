import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String operation;
  final String description;
  final Color? operationColor;
  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    required this.operation,
    required this.description,
    this.operationColor = Colors.black,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      child: Center(
        child: Text(
          operation,
          style: const TextStyle(
            fontFamily: 'Menlo',
          ),
        ),
      ),
    );
  }
}
