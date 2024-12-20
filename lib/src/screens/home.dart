import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('memo app', style: TextStyle(fontSize: 24),),
            const Text(
              'store all your ideas without skipping a beat',
            ),
            SizedBox(height: 32,),
            ElevatedButton(onPressed: () => Navigator.of(context).pushNamed('/create'), child: Text('Create')),
            ElevatedButton(onPressed: () => Navigator.of(context).pushNamed('/ideas'), child: Text('Ideas'),),
          ],
        ),
      ),
    );
  }
}
