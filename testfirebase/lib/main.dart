import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase/modal/items.dart';
import 'package:testfirebase/widget/card_modal_bottom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widget/card_body_widget.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<DataItems> items = [];

  @override
  void initState() {
    FirebaseFirestore.instance.collection("todo").snapshots().listen((event) {
      setState(() {
        items.clear();
      });
      for (final item in event.docs) {
        setState(() {
          items.add(DataItems(id: item.id, name: item.data()["text"]));
        });
      }
    });
    super.initState();
  }

  void _handleAddTask(String name) {
    FirebaseFirestore.instance.collection('todo').add(<String, dynamic>{
      'text': name,
    });
  }

  void _handleDeleteTask(String id) {
    FirebaseFirestore.instance.collection("todo").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'ToDoList',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: items
                .map((item) => CardBody(
                      index: items.indexOf(item),
                      item: item,
                      handleDelete: _handleDeleteTask,
                    ))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext content) {
                return ModalBottom(addTask: _handleAddTask);
              },
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ));
  }
}
