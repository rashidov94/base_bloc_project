import 'package:bloc_pattern/feature/data/data_sources/app_database.dart';
import 'package:bloc_pattern/feature/data/repositories/app_repository.dart';
import 'package:bloc_pattern/feature/domain/usecases/get_all_todo.dart';
import 'package:bloc_pattern/feature/presentation/bloc/add_todo_cubit.dart';
import 'package:bloc_pattern/feature/presentation/bloc/all_todo_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import 'feature/domain/repositories/todo_repository.dart';
import 'feature/domain/usecases/add_todo.dart';

final container = GetIt.instance;

Future<void> init() async {
  //! Features - TodoApp

  //Bloc
  container
      .registerFactory(() => AllTodoCubit(getAllTodo: container<GetAllTodo>()));
  container.registerFactory(() => AddTodoCubit(addTodo: container<AddTodo>()));

  //UseCase
  container
      .registerLazySingleton(() => GetAllTodo(container<TodoRepository>()));
  container.registerLazySingleton(() => AddTodo(container<TodoRepository>()));

  //Repository
  container.registerLazySingleton<TodoRepository>(
      () => AppRepository(appDatabase: container<AppDatabase>()));

  // Data sources
  container.registerLazySingleton<AppDatabase>(
      () => AppDatabase(db: container<Database>()));

  //External
  final database = await AppDatabase.open();
  container.registerLazySingleton<Database>(() => database);
}
