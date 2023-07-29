import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pingolearn/provider/product_provider.dart';
import 'package:pingolearn/screen/UI.dart';
import 'package:pingolearn/screen/auth/e_signup.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>ProductProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
        )
    );
  }
}

