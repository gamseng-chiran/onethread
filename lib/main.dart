import 'package:onethread/main.dart';
import 'package:flutter/material.dart';

import 'list.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final todoList = ToDo.todoList();
  var _ToDoController = TextEditingController();

  void _handle(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void addItem(String toDO) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDO));
      
    _ToDoController.clear();
    });

  
      
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Stack(children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 60, bottom: 20),
                        child: Text(
                          'ToDos',
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      for (ToDo todo in todoList)
                        (ToDoItem(
                          todo: todo,
                          ToDoChange: _handle,
                          Delete: _deleteItem,
                        ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: 25, right: 20, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: TextField(
                  controller: _ToDoController,
                  decoration: InputDecoration(
                    helperStyle: TextStyle(color: Colors.black,fontSize: 16),
                      hintText: 'Add to do', border: InputBorder.none),
                ),
              )),
              
              Container(
                margin: EdgeInsets.only(bottom: 25, right: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                        minimumSize: Size(30, 30),
                        shape: CircleBorder(), 
                        elevation: 10),
                    onPressed: () {
                      if(_ToDoController.text.isNotEmpty){
                        addItem(_ToDoController.text);
                      }
                      
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 30,
                      color: Colors.black38),
                    )),
              )
            ]),
          )
        ]));;

  }
}