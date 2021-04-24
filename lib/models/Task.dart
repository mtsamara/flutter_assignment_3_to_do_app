class Task {
  String id;
  String title;
  String description;
  bool isCompleted;

  Task({this.id, this.title, this.description, this.isCompleted});

  @override
  String toString() {
    return 'ID: $id\nTitle: $title\nDescription: $description\nCompleted: ${isCompleted ? "Yes" : "No"}';
  }
}
