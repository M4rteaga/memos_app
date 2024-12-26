import 'package:flutter/material.dart';
import 'package:memo_app/src/models/memo_object.dart';

class RecordingCard extends StatelessWidget {
  const RecordingCard({super.key, required this.data, this.onTap});
  final MemoObject data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            padding: EdgeInsets.all(12),
            child: Icon(
              Icons.voicemail,
              color: Colors.black12,
              size: 82,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            data.name,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
