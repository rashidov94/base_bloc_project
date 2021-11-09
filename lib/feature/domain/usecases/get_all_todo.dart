import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/core/usecases/usecase.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:bloc_pattern/feature/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllTodo extends UseCase<List<TodoEntity>, NoParams> {
  final TodoRepository _todoRepository;

  GetAllTodo(this._todoRepository);

  @override
  Future<Either<Failure, List<TodoEntity>>> call(NoParams params) {
    return _todoRepository.getAllTodo();
  }
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
