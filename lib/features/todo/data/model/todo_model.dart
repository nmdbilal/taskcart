import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel({
    super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
    id: map['id'] as int?,
    title: map['title']?.toString() ?? '',
    description: map['description']?.toString() ?? '',
    isCompleted: (map['isCompleted'] ?? 0) == 1,
    createdAt: map['createdAt'] != null
        ? DateTime.tryParse(map['createdAt'].toString()) ??
        DateTime.now()
        : DateTime.now(),
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'title': title,
    'description': description,
    'isCompleted': isCompleted ? 1 : 0,
    'createdAt': createdAt.toIso8601String(),
  };

  static TodoModel fromEntity(TodoEntity entity) => TodoModel(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    isCompleted: entity.isCompleted,
    createdAt: entity.createdAt,
  );
}