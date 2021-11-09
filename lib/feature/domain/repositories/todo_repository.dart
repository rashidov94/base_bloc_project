import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TodoRepository {

  Future<Either<Failure, int>> deleteTodo(int id);

  Future<Either<Failure, List<TodoEntity>>> getAllTodo();

  Future<Either<Failure, TodoEntity?>> getTodo(int id);

  Future<Either<Failure, TodoEntity>> insertTodo(TodoEntity todoEntity);

  Future<Either<Failure, int>> updateTodo(TodoEntity todoEntity);
}
