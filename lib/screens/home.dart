import 'package:coolapp/constants/colors.dart';
import 'package:coolapp/model/todo.dart';
import 'package:coolapp/widgets/todo_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final toDoList = Todo.todoList();
  List<Todo> _foundToDo = [];
  final _toDoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundToDo = toDoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _bulidAppBar(),
        body: Stack(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(children: [
                  Expanded(
                      child: ListView(
                    children: [
                      searchBox(),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: const Text(
                          "All Todos",
                          style: TextStyle(
                              color: tdBlack,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todoo in _foundToDo)
                        TodoItem(
                          todo: todoo,
                          onToDoChange: _handleToDoChange,
                          onDeleteItem: _handleDeleteItem,
                        )
                    ],
                  ))
                ])),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: 20, right: 20, left: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _toDoController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Add Todo",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ))),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                      ),
                      child: ElevatedButton(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                        onPressed: () {
                          _handleAddItem(_toDoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  void _handleToDoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteItem(Todo todo) {
    setState(() {
      toDoList.remove(todo);
    });
  }

  void _handleAddItem(String text) {
    setState(() {
      toDoList.add(Todo(
        title: text,
        isDone: false,
      ));
      _toDoController.clear();
    });
  }

  void _search(String text) {
    List<Todo> results = [];
    if (text.isEmpty) {
      results = toDoList;
    } else {
      results = toDoList
          .where(
              (item) => item.title!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Container searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (value) => _search(value),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  AppBar _bulidAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: tdBlack,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.person,
                  color: tdBGColor,
                  size: 20,
                ))
          ],
        ));
  }
}
