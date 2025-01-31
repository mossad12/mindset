import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/ui/utils/AppThemes.dart';
import '../../data/model/ToDoModel.dart';
import '../providers/AppProvider.dart';
import '../utils/AppColors.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  void _showEditDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: todo.title);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: AppColors.primaryColor,
        title:  Text('Edit Task' ,style: AppThemes.lightTheme.textTheme.titleLarge,),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Edit task title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text('Cancel',style: AppThemes.lightTheme.textTheme.titleLarge!.copyWith(
              color: AppColors.redColor
            )),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                todoProvider.updateTodo(
                  Todo(
                    id: todo.id,
                    title: controller.text.trim(),
                    completed: todo.completed,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child:  Text('Save',style: AppThemes.lightTheme.textTheme.titleLarge),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.whiteColor,
      shadowColor: AppColors.greyColor,
      surfaceTintColor: AppColors.primaryColor,
      child: ListTile(
        leading: Checkbox(
          value: todo.completed,
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            todoProvider.updateTodo(
              Todo(
                id: todo.id,
                title: todo.title,
                completed: value!,
              ),
            );
          },
        ),
        title: Text(
          todo.title,
          style: AppThemes.lightTheme.textTheme.titleMedium!.copyWith(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            color: todo.completed ? AppColors.greyColor : AppColors.blackColor,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon:  Icon(Icons.edit, color: AppColors.primaryColor),
              onPressed: () => _showEditDialog(context),
            ),
            IconButton(
              icon:  Icon(Icons.delete, color: AppColors.redColor),
              onPressed: () => todoProvider.deleteTodo(todo.id),
            ),
          ],
        ),
      ),
    );
  }
}