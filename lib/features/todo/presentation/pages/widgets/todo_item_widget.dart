import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';
import 'package:taskcart/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:taskcart/features/todo/presentation/pages/widgets/todo_form_dialog.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoEntity todo;
  const TodoItemWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: GestureDetector(
          onTap: () => context.read<TodoBloc>().add(ToggleTodoEvent(todo: todo)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 26.w,
            height: 26.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: todo.isCompleted ? Colors.green : Colors.transparent,
              border: Border.all(
                color: todo.isCompleted ? Colors.green : Colors.grey,
                width: 2,
              ),
            ),
            child: todo.isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                : null,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: todo.description.isNotEmpty
            ? Text(
          todo.description,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, size: 20.sp, color: Colors.blue),
              onPressed: () async {
                final result = await showDialog<Map<String, String>>(
                  context: context,
                  builder: (_) => TodoFormDialog(existingTodo: todo),
                );
                if (result != null && context.mounted) {
                  context.read<TodoBloc>().add(UpdateTodoEvent(
                    todo: todo.copyWith(
                      title: result['title'],
                      description: result['description'],
                    ),
                  ));
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20.sp, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Delete Task'),
                    content: const Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel')),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodoEvent(id: todo.id!));
                          Navigator.pop(context);
                        },
                        child: const Text('Delete', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}