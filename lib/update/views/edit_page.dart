import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditThread extends StatefulWidget {
  final String content;
  final int id;
  const EditThread({super.key, required this.content, required this.id});

  @override
  State<EditThread> createState() => _EditThreadState();
}

class _EditThreadState extends State<EditThread> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
