import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:bloc_pattern/feature/domain/usecases/get_all_todo.dart';
import 'package:bloc_pattern/feature/presentation/state/all_todo_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllTodoCubit extends Cubit<AllTodoState> {
  final GetAllTodo getAllTodo;

  AllTodoCubit({required this.getAllTodo})
      : super(const AllTodoState(stateStatus: StateStatus.initial));

  void getAllTodoFromRepo() async {
    emit(state.copyWith(stateStatus: StateStatus.loading));
    Either<Failure, List<TodoEntity>> failureOrTodos =
        await getAllTodo(const NoParams());

    failureOrTodos.fold(
        (failure) => emit(
            state.copyWith(stateStatus: StateStatus.failure, failure: failure)),
        (todos) => emit(
            state.copyWith(stateStatus: StateStatus.success, todos: todos)));
  }
}
