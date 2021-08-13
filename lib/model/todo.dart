final String tableTodo = 'todo';

class TodoFields {
  static final List<String> values = [id, number, title, description];

  static final String id = '_id';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
}

class Todo {
  final int? id;
  final int number;
  final String title;
  final String description;

  const Todo(
      {this.id,
      required this.number,
      required this.title,
      required this.description});

  Todo copy({int? id, int? number, String? title, String? description}) => Todo(
      id: id ?? this.id,
      number: number ?? this.number,
      title: title ?? this.title,
      description: description ?? this.description);

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.number: number,
        TodoFields.title: title,
        TodoFields.description: description
      };

  static Todo fromJson(Map<String, Object?> json) => Todo(
      id: json[TodoFields.id] as int?,
      number: json[TodoFields.number] as int,
      title: json[TodoFields.title] as String,
      description: json[TodoFields.description] as String);
}
