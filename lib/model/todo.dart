class Todo {
  String? id;
  String? title;
  bool isDone;

  Todo({
    this.id,
    this.title,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(
        id: "1",
        title: "Your 1st todo!!",
        isDone: false,
      ),
    ];
  }
}
