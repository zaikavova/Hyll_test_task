import 'package:flutter/material.dart';

class InitialErrorStateWidget extends StatelessWidget {
  const InitialErrorStateWidget({
    super.key,
    required this.errorMessage,
    required this.onRetryPressed,
  });

  final String errorMessage;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          InkWell(
            onTap: onRetryPressed,
            child: Ink(
              child: Icon(Icons.replay),
            ),
          ),
        ],
      ),
    );
  }
}
