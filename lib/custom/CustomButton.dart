import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TextFrame.dart';

class CustomButton extends StatelessWidget {

  final void Function() onPressed;
  final String comment;

  CustomButton({super.key, required this.comment, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey[500]),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10)),
                ),
                onPressed: onPressed,
                child: TextFrame(
                  comment: comment,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }
}
