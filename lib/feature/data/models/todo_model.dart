import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel(
      {int? id,
      required String label,
      required description,
      required createdDate})
      : super(
            id: id,
            label: label,
            description: description,
            createdDate: createdDate);

  TodoModel copyWith(
      {int? id, String? label, String? description, int? createdDate}) {
    return TodoModel(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        createdDate: createdDate ?? this.createdDate);
  }

  factory TodoModel.fromMap(Map<String, dynamic> json) => TodoModel(
        label: json["label"],
        description: json["description"],
        createdDate: json["created_date"],
      );

  Map<String, dynamic> toMap() => {
        "label": label,
        "description": description,
        "created_date": createdDate,
      };
}
