import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:bloc_pattern/feature/domain/usecases/add_todo.dart';
import 'package:bloc_pattern/feature/presentation/state/add_todo_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final AddTodo addTodo;

  AddTodoCubit({required this.addTodo})
      : super(const AddTodoState(stateStatus: StateStatus.initial));

  void insertTodo(TodoEntity todoEntity) async {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    Either<Failure, TodoEntity> failureOrTodo =
        await addTodo(Param(todoEntity: todoEntity));

    failureOrTodo.fold(
        (failure) => emit(
            state.copyWith(stateStatus: StateStatus.failure, failure: failure)),
        (todo) => emit(state.copyWith(
            stateStatus: StateStatus.success, todoEntity: todo)));
  }
}
