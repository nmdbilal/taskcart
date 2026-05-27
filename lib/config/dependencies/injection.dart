import 'package:get_it/get_it.dart';
import 'package:taskcart/features/ecommerce/data/datasource/ecommerce_datasource_impl.dart';
import 'package:taskcart/features/todo/data/datasource/todo_datasource.dart';
import 'package:taskcart/features/todo/data/datasource/todo_datasource_impl.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo_impl.dart';
import 'package:taskcart/features/todo/domain/repository/todo_repo.dart';
import 'package:taskcart/features/todo/domain/usecase/add_todo_usecase.dart';
import 'package:taskcart/features/todo/domain/usecase/delete_todo_usecase.dart';
import 'package:taskcart/features/todo/domain/usecase/get_todo_usecase.dart';
import 'package:taskcart/features/todo/domain/usecase/update_todo_usecase.dart';
import 'package:taskcart/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:taskcart/features/ecommerce/data/datasource/ecommerce_datasource.dart';
import 'package:taskcart/features/ecommerce/domain/repository/ecommerce_repo_impl.dart';
import 'package:taskcart/features/ecommerce/domain/repository/ecommerce_repo.dart';
import 'package:taskcart/features/ecommerce/domain/usecase/get_home_data_uc.dart';
import 'package:taskcart/features/ecommerce/presentation/bloc/ecommerce_bloc.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async {
  sl.registerLazySingleton<TodoDatasource>(() => TodoDatasourceImpl());
  sl.registerLazySingleton<TodoRepo>(() => TodoRepoImpl(datasource: sl()));
  sl.registerLazySingleton(() => GetTodosUsecase(repo: sl()));
  sl.registerLazySingleton(() => AddTodoUsecase(repo: sl()));
  sl.registerLazySingleton(() => UpdateTodoUsecase(repo: sl()));
  sl.registerLazySingleton(() => DeleteTodoUsecase(repo: sl()));
  sl.registerFactory<TodoBloc>(() => TodoBloc(
    getTodosUsecase: sl(),
    addTodoUsecase: sl(),
    updateTodoUsecase: sl(),
    deleteTodoUsecase: sl(),
  ));
  sl.registerLazySingleton<EcommerceDatasource>(() => EcommerceDatasourceImpl());
  sl.registerLazySingleton<EcommerceRepo>(() => EcommerceRepoImpl(datasource: sl()));
  sl.registerLazySingleton(() => GetHomeDataUsecase(repo: sl()));
  sl.registerFactory<EcommerceBloc>(() => EcommerceBloc(getHomeDataUsecase: sl()));
}