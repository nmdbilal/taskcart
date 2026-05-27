import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';
import 'package:taskcart/features/todo/domain/usecase/add_todo_usecase.dart';
import 'package:taskcart/features/todo/domain/usecase/delete_todo_usecase.dart';
import 'package:taskcart/features/todo/domain/usecase/get_todo_usecase.dart';
import 'package:taskcart/features/todo/domain/usecase/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUsecase getTodosUsecase;
  final AddTodoUsecase addTodoUsecase;
  final UpdateTodoUsecase updateTodoUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;

  TodoBloc({
    required this.getTodosUsecase,
    required this.addTodoUsecase,
    required this.updateTodoUsecase,
    required this.deleteTodoUsecase,
  }) : super(TodoInitial()) {
    on<GetTodosEvent>(_onGetTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<FilterTodosEvent>(_onFilterTodos);
  }

  List<TodoEntity> _applyFilter(List<TodoEntity> todos, TodoFilter filter) {
    switch (filter) {
      case TodoFilter.completed:
        return todos.where((t) => t.isCompleted).toList();
      case TodoFilter.pending:
        return todos.where((t) => !t.isCompleted).toList();
      case TodoFilter.all:
        return todos;
    }
  }

  Future<void> _onGetTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final result = await getTodosUsecase.call(NoParams());
    result.fold(
          (failure) => emit(TodoFailure(message: failure.message)),
          (success) => emit(TodoSuccess(
        allTodos: success,
        filteredTodos: success,
        activeFilter: TodoFilter.all,
      )),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final newTodo = TodoEntity(
      title: event.title,
      description: event.description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    await addTodoUsecase.call(newTodo);
    add(GetTodosEvent());
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    await updateTodoUsecase.call(event.todo);
    add(GetTodosEvent());
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    await deleteTodoUsecase.call(event.id);
    add(GetTodosEvent());
  }

  Future<void> _onToggleTodo(ToggleTodoEvent event, Emitter<TodoState> emit) async {
    final updated = event.todo.copyWith(isCompleted: !event.todo.isCompleted);
    await updateTodoUsecase.call(updated);
    add(GetTodosEvent());
  }

  Future<void> _onFilterTodos(FilterTodosEvent event, Emitter<TodoState> emit) async {
    if (state is TodoSuccess) {
      final current = state as TodoSuccess;
      emit(TodoSuccess(
        allTodos: current.allTodos,
        filteredTodos: _applyFilter(current.allTodos, event.filter),
        activeFilter: event.filter,
      ));
    }
  }
}