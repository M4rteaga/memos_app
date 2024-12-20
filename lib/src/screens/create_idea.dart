import 'package:flutter/material.dart';

class CreateIdeaPage extends StatelessWidget {
  const CreateIdeaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record your idea'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Start recording'),
            TextButton(
                onPressed: () => {},
                child: Icon(
                  Icons.radio_button_checked_rounded,
                  color: Colors.red,
                  size: 46,
                ))
          ],
        ),
      ),
    );
  }
}
