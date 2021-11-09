import 'package:bloc_pattern/core/base/base_state.dart';
import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';

class AddTodoState extends BaseState {
  final TodoEntity? todoEntity;
  final Failure? failure;

  const AddTodoState(
      {required StateStatus stateStatus, this.todoEntity, this.failure})
      : super(stateStatus);

  AddTodoState copyWith(
      {StateStatus? stateStatus, TodoEntity? todoEntity, Failure? failure}) {
    return AddTodoState(
        stateStatus: stateStatus ?? this.stateStatus,
        todoEntity: todoEntity ?? this.todoEntity,
        failure: failure ?? this.failure);
  }
}
