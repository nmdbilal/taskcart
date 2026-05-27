part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();
}

class GetTodosEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  const AddTodoEvent({required this.title, required this.description});
  @override
  List<Object?> get props => [title, description];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;
  const UpdateTodoEvent({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  const DeleteTodoEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ToggleTodoEvent extends TodoEvent {
  final TodoEntity todo;
  const ToggleTodoEvent({required this.todo});
  @override
  List<Object?> get props => [todo];
}

class FilterTodosEvent extends TodoEvent {
  final TodoFilter filter;
  const FilterTodosEvent({required this.filter});
  @override
  List<Object?> get props => [filter];
}

enum TodoFilter { all, completed, pending }