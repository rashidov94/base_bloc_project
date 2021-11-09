import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int? id;
  final String label;
  final String description;
  final int createdDate;

  const TodoEntity(
      {this.id,
      required this.label,
      required this.description,
      required this.createdDate});

  @override
  List<Object?> get props => [id , label, description, createdDate];
}
