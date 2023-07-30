import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ModalBottom extends StatelessWidget {
  ModalBottom({Key? key, required this.addTask}) : super(key: key);

  final Function addTask;
  TextEditingController controller = TextEditingController();

  void _handleOnclick(BuildContext context) {
    final name = controller.text;
    if (name.isEmpty) {
      return;
    }
    addTask(name);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Your Task'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () => _handleOnclick(context),
                  child: const Text('Add Task')),
            )
          ],
        ),
      ),
    );
  }
}
