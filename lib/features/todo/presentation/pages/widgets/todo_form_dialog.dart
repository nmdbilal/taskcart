import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcart/features/todo/domain/entities/todo_entity.dart';

class TodoFormDialog extends StatefulWidget {
  final TodoEntity? existingTodo;
  const TodoFormDialog({super.key, this.existingTodo});

  @override
  State<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends State<TodoFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTodo?.title ?? '');
    _descController = TextEditingController(text: widget.existingTodo?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingTodo != null;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        isEdit ? 'Edit Task' : 'New Task',
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Title required' : null,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _descController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                    color: Colors.grey.shade400
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Description required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'title': _titleController.text.trim(),
                'description': _descController.text.trim(),
              });
            }
          },
          child: Text(isEdit ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}