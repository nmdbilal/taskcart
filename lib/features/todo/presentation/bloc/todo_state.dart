part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();
}

final class TodoInitial extends TodoState {
  @override
  List<Object?> get props => [];
}

final class TodoLoading extends TodoState {
  @override
  List<Object?> get props => [];
}

final class TodoSuccess extends TodoState {
  final List<TodoEntity> allTodos;
  final List<TodoEntity> filteredTodos;
  final TodoFilter activeFilter;

  const TodoSuccess({
    required this.allTodos,
    required this.filteredTodos,
    required this.activeFilter,
  });

  @override
  List<Object?> get props => [allTodos, filteredTodos, activeFilter];
}

final class TodoFailure extends TodoState {
  final String message;
  const TodoFailure({required this.message});
  @override
  List<Object?> get props => [message];
}