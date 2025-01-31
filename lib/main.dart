import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/ui/providers/AppProvider.dart';
import 'package:to_do_list/ui/screens/home_screen.dart';
import 'package:to_do_list/ui/utils/AppThemes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 934),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          home: HomeScreen(),
        );
      },

    );
  }
}