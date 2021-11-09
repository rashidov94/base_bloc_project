import 'package:bloc_pattern/core/base/base_state.dart';
import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';

class AllTodoState extends BaseState {
  final List<TodoEntity>? todos;
  final Failure? failure;

  const AllTodoState(
      {required StateStatus stateStatus, this.todos, this.failure})
      : super(stateStatus);

  AllTodoState copyWith(
      {StateStatus? stateStatus, List<TodoEntity>? todos, Failure? failure}) {
    return AllTodoState(
        stateStatus: stateStatus ?? this.stateStatus,
        todos: todos ?? this.todos,
        failure: failure ?? this.failure);
  }
}
