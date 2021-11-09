import 'package:bloc_pattern/core/error/exception.dart';
import 'package:bloc_pattern/core/error/failure.dart';
import 'package:bloc_pattern/feature/data/data_sources/app_database.dart';
import 'package:bloc_pattern/feature/data/models/todo_model.dart';
import 'package:bloc_pattern/feature/domain/entities/todo_entity.dart';
import 'package:bloc_pattern/feature/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class AppRepository implements TodoRepository {
  final AppDatabase appDatabase;

  AppRepository({required this.appDatabase});

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      int deletedId = await appDatabase.delete(id);
      return Right(deletedId);
    } on JsonCastException {
      return left(JsonCastFailure());
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodo() async {
    try {
      List<TodoEntity> todoEntities = await appDatabase.getAllTodo();
      return Right(todoEntities);
    } on JsonCastException {
      return left(JsonCastFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity?>> getTodo(int id) async {
    try {
      TodoEntity? todoEntity = await appDatabase.getTodo(id);
      return Right(todoEntity);
    } on JsonCastException {
      return left(JsonCastFailure());
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> insertTodo(TodoEntity todoEntity) async {
    try {
      TodoEntity insertedTodoEntity = await appDatabase.insert(TodoModel(
          id: todoEntity.id,
          label: todoEntity.label,
          description: todoEntity.description,
          createdDate: todoEntity.createdDate));
      return Right(insertedTodoEntity);
    } on JsonCastException {
      return left(JsonCastFailure());
    }
  }

  @override
  Future<Either<Failure, int>> updateTodo(TodoEntity todoEntity) async {
    try {
      int updatedId = await appDatabase.update(todoEntity as TodoModel);
      return Right(updatedId);
    } on JsonCastException {
      return left(JsonCastFailure());
    }
  }
}
