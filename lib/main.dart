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
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
