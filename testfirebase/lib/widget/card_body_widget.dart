import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardBody extends StatelessWidget {
  CardBody(
      {Key? key,
      required this.item,
      required this.handleDelete,
      required this.index})
      : super(key: key);

  var item;
  var index;
  final Function handleDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: (index % 2 == 0)
            ? const Color.fromARGB(255, 217, 216, 214)
            : const Color.fromARGB(255, 74, 176, 227),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 39, 37, 37),
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () async {
                if (await confirm(
                  context,
                  title: const Text('Confirm'),
                  content: const Text('Would you like to remove?'),
                  textOK: const Text('Yes'),
                  textCancel: const Text('No'),
                )) {
                  handleDelete(item.id);
                }
                return;
              },
              child: const Icon(
                Icons.delete_outline,
                color: Color.fromARGB(255, 22, 20, 20),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
