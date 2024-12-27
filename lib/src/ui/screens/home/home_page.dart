import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.primaryAction, this.secondaryAction});
  final VoidCallback? primaryAction;
  final VoidCallback? secondaryAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: MediaQuery.of(context).size.height / 2,
              child: Column(
                spacing: 12,
                children: [
                  const Text(
                    'Memo app',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Store all your ideas without skipping a beat',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    OutlinedButton(
                      onPressed: secondaryAction,
                      style: ButtonStyle(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Text(
                          'Ideas',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: primaryAction,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Text(
                          'Record',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
