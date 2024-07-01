import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.result});
  final String result;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Your results!",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            height: 15,
          ),
          Text(result),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
