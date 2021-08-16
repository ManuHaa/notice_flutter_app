final String tableTodo = 'todo';

class TodoFields {
  static final List<String> values = [id, title, dateTime, priority, status];

  static final String id = '_id';
  static final String title = 'title';
  static final String dateTime = 'dateTime';
  static final String priority = 'priority';
  static final String status = 'status';
}

class Todo {
  final int? id;
  final String title;
  final DateTime dateTime;
  final String priority;
  final int status; // 0 incomplete, 1 complete

  const Todo(
      {this.id,
      required this.title,
      required this.dateTime,
      required this.priority,
      required this.status});

  Todo copy(
          {int? id,
          String? title,
          DateTime? dateTime,
          String? priority,
          int? status}) =>
      Todo(
          id: id ?? this.id,
          title: title ?? this.title,
          dateTime: dateTime ?? this.dateTime,
          priority: priority ?? this.priority,
          status: status ?? this.status);

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.title: title,
        TodoFields.dateTime: dateTime,
        TodoFields.priority: priority,
        TodoFields.status: status
      };

  static Todo fromJson(Map<String, Object?> json) => Todo(
      id: json[TodoFields.id] as int?,
      title: json[TodoFields.title] as String,
      dateTime: json[TodoFields.dateTime] as DateTime,
      priority: json[TodoFields.priority] as String,
      status: json[TodoFields.status] as int);
}
