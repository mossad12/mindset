import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/ui/utils/AppColors.dart';
import 'package:to_do_list/ui/utils/AppThemes.dart';
import '../providers/AppProvider.dart';
import '../widgets/tak_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).fetchTodos();
    });
  }

  void _showAddDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: AppColors.primaryColor,
        title:  Text('Add New Task',style: AppThemes.lightTheme.textTheme.titleLarge),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text('Cancel',style: AppThemes.lightTheme.textTheme.titleLarge!.copyWith(color: AppColors.redColor)),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Provider.of<TodoProvider>(context, listen: false)
                    .addTodo(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child:  Text('Add',style: AppThemes.lightTheme.textTheme.titleLarge),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('To-Do List',style: AppThemes.lightTheme.textTheme.titleLarge!.copyWith(
          color: AppColors.whiteColor
        ),),
        actions: [
          IconButton(
            icon:  Icon(Icons.refresh,color: AppColors.whiteColor,),
            onPressed: () => Provider.of<TodoProvider>(context, listen: false).fetchTodos(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(60.h),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: AppColors.whiteColor,
                filled: true,
                contentPadding:  EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.w),
                hintMaxLines: 1,
                hintText: 'Search tasks...',
                hintStyle: AppThemes.lightTheme.textTheme.titleMedium!.copyWith(color: AppColors.greyColor),
                prefixIcon:  Icon(Icons.search , color: AppColors.greyColor,),
                suffixIcon: IconButton(
                  icon:  Icon(Icons.clear,color: AppColors.greyColor,),
                  onPressed: () {
                    _searchController.clear();
                    todoProvider.updateSearchQuery('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) => todoProvider.updateSearchQuery(query),
            ),
          ),
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (todoProvider.errorMessage != null) {
            return Center(child: Text(todoProvider.errorMessage!));
          }

          return ListView.builder(
            itemCount: todoProvider.filteredTodos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.filteredTodos[index];
              return TodoItem(todo: todo);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child:  Icon(Icons.add,color: AppColors.whiteColor,),
      ),
    );
  }
}