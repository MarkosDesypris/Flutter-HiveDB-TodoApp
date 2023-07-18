class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Go to Gym', isDone: true),
      ToDo(id: '02', todoText: 'Check the Emails'),
      ToDo(id: '03', todoText: 'Prepare lunch box'),
    ];
  }
}
