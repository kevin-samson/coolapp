import 'package:coolapp/constants/colors.dart';
import 'package:coolapp/model/todo.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onToDoChange;
  final onDeleteItem;

  const TodoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChange,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        title: Text(
          todo.title!,
          style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: tdBlack,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed: () {
                onDeleteItem(todo);
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              iconSize: 18,
            )),
      ),
    );
  }
}
