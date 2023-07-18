import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_tile.dart';
import '../constats/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Create the Controller for ADD Button and Search Field
  final _todoController = TextEditingController();
  final _searchController = TextEditingController();

  // Initialize the List
  final List<ToDo> todoList = ToDo.todoList();
  List<ToDo> _foundTodo = [];

  @override
  void initState() {
    super.initState();
    _foundTodo = todoList;
  }

  @override
  void dispose() {
    super.dispose();
    _todoController.dispose();
  }

  void _addToDoItem(String text) {
    // A Easy Way when you have text in the searchbar, you can add a new todo.
    _searchController.clear();
    _runFilter();

    setState(() {
      todoList.add(ToDo(id: todoList.length.toString(), todoText: text));
    });
    _todoController.clear();
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((todo) => todo.id == id);
    });
  }

  void _runFilter([String keyword = '']) {
    List<ToDo> result = [];
    if (keyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((todo) =>
              todo.todoText.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: tdBGColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(
              Icons.menu,
              color: tdBlack,
              size: 30.0,
            ),
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                  'https://media.istockphoto.com/id/1227618801/vector/human-face-avatar-icon-profile-for-social-network-man-vector-illustration.jpg?s=170667a&w=0&k=20&c=YW_cwPaiX8pHXaOGiX_3tQKRk8NU0ef8ylNq23HdxDI='),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                      controller: _searchController,
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: tdBlack,
                          size: 20.0,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 20,
                          minWidth: 30,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: tdGrey),
                      )),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todo in _foundTodo.reversed)
                        TodoItem(
                          todo: todo,
                          onToDoChange: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 15,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0),
                    ],
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Add a new ToDo Item',
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () => _addToDoItem(_todoController.text),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: const Size(50, 50),
                        elevation: 10.0),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
