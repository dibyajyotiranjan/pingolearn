
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextFormField(

      ),
    );
  }
}
