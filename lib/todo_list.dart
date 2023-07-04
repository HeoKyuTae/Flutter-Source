import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_source/todo_controller.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TodoController _todoController = TodoController();

  @override
  void initState() {
    _todoController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Text('${_todoController.counter}'),
                  ),
                ),
              ),
              Container(
                height: 60,
                color: Colors.amber,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _todoController.defaultCounter();
                        },
                        child: const Text('초기화')),
                    Container(
                      width: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _todoController.outcrease();
                        },
                        child: const Text('outcrease')),
                    Container(
                      width: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _todoController.increase();
                        },
                        child: const Text('increase')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
