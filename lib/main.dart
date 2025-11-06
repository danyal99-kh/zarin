import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarin/screens/home_screen.dart';
import 'form_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => FormProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,

        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: const Color.fromARGB(255, 50, 58, 108).withOpacity(0.9),
          elevation: 8,
          shadowColor: Colors.black45,
        ),

        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
        ),
      ),

      home: const HomeScreen(),
    );
  }
}
