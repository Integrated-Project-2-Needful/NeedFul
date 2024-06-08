import 'package:flutter/material.dart';
import 'package:needful/Utils/color_use.dart';

class TextForm extends StatefulWidget {
  final String? label;
  final int? maxLine;
  final TextEditingController? controller;
  final bool? filled;

  const TextForm({
    super.key,
    this.label,
    this.controller,
    this.maxLine,
    this.filled,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextFormField(
            maxLines: widget.maxLine,
            decoration: InputDecoration(
              filled: widget.filled?? false,
              fillColor: widget.filled== true? Colors.white : colorUse.backgroundColor,
              border: const OutlineInputBorder(),
              hintText: widget.label,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: widget.controller,
          ),
        ),
      ),
    );
  }
}
