import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcart/features/todo/presentation/bloc/todo_bloc.dart';
import 'widgets/todo_form_dialog.dart';
import 'widgets/todo_item_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('My Tasks', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TodoFailure) {
            return Center(child: Text(state.message));
          }
          if (state is TodoSuccess) {
            return Column(
              children: [
                _buildFilterBar(context, state.activeFilter),
                _buildStats(state),
                Expanded(
                  child: state.filteredTodos.isEmpty
                      ? _buildEmptyState(state.activeFilter)
                      : ListView.builder(
                    padding: EdgeInsets.only(bottom: 80.h),
                    itemCount: state.filteredTodos.length,
                    itemBuilder: (_, i) =>
                        TodoItemWidget(todo: state.filteredTodos[i]),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(
            context: context,
            builder: (_) => const TodoFormDialog(),
          );
          if (result != null && context.mounted) {
            context.read<TodoBloc>().add(AddTodoEvent(
              title: result['title']!,
              description: result['description']!,
            ));
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context, TodoFilter active) {
    const labels = {
      TodoFilter.all: 'All',
      TodoFilter.pending: 'Pending',
      TodoFilter.completed: 'Completed',
    };

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: TodoFilter.values.map((filter) {
          final isActive = filter == active;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: GestureDetector(
                onTap: () =>
                    context.read<TodoBloc>().add(FilterTodosEvent(filter: filter)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isActive ? Colors.blue : Colors.grey.shade300,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    labels[filter]!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isActive ? Colors.white : Colors.grey[700],
                      fontWeight:
                      isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStats(TodoSuccess state) {
    final total = state.allTodos.length;
    final done = state.allTodos.where((t) => t.isCompleted).length;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('Total', total, Colors.blue),
          _statItem('Done', done, Colors.green),
          _statItem('Pending', total - done, Colors.orange),
        ],
      ),
    );
  }

  Widget _statItem(String label, int count, Color color) {
    return Column(
      children: [
        Text('$count',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildEmptyState(TodoFilter filter) {
    final messages = {
      TodoFilter.all: 'No tasks yet.\nTap + to add your first task!',
      TodoFilter.completed: 'No completed tasks yet.',
      TodoFilter.pending: 'No pending tasks. All done!',
    };
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist_rounded, size: 64.sp, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          Text(
            messages[filter]!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.sp, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}