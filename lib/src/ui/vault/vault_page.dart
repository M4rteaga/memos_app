import 'package:flutter/material.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ideas'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.voicemail,
                    color: Colors.black12,
                    size: 82,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Container(
                  child: Icon(
                    Icons.voicemail,
                    color: Colors.black12,
                    size: 82,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Container(
                  child: Icon(
                    Icons.voicemail,
                    color: Colors.black12,
                    size: 82,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
