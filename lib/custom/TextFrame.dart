import 'package:flutter/cupertino.dart';

class TextFrame extends StatelessWidget {

  final String comment;
  final TextOverflow? overflow;
  final Color? color;

  const TextFrame({
    super.key,
    required this.comment,
    this.overflow,
    this.color});

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Text(
      comment,
      style: TextStyle(
        fontSize: appHeight * 0.0168,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}