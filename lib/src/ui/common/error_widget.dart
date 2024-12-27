import 'package:flutter/material.dart';
import 'package:memo_app/src/models/exceptions.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.exception});
  static const path = '/error';
  final CustomMemosException exception;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        textDirection: TextDirection.ltr,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 350,
                  child: Text(
                    exception.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                exception.subMessage != null
                    ? Text(
                        exception.subMessage ?? '',
                        textAlign: TextAlign.center,
                      )
                    : SizedBox(),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.indigo),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Try latter',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
