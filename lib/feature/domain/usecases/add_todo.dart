import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/core/usecases/usecase.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:bloc_pattern/feature/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddTodo extends UseCase<TodoEntity, Param> {
  final TodoRepository _todoRepository;

  AddTodo(this._todoRepository);

  @override
  Future<Either<Failure, TodoEntity>> call(Param params) {
    return _todoRepository.insertTodo(params.todoEntity);
  }
}

class Param extends Equatable {
  final TodoEntity todoEntity;

  const Param({required this.todoEntity});

  @override
  List<Object?> get props => [todoEntity];
}
