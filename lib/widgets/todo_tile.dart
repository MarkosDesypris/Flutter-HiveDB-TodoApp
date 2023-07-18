import 'package:flutter/material.dart';
import 'package:todo_app/constats/colors.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final Function onToDoChange;
  final Function onDeleteItem;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToDoChange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
          onTap: () => onToDoChange(todo),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: todo.isDone
              ? const Icon(Icons.check_box, color: tdBlue)
              : const Icon(Icons.check_box_outline_blank, color: tdBlue),
          title: Text(
            todo.todoText,
            style: TextStyle(
              fontSize: 16.0,
              color: tdBlack,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              iconSize: 20,
              color: Colors.white,
              onPressed: () => onDeleteItem(todo.id),
              icon: const Icon(Icons.delete),
            ),
          )),
    );
  }
}
