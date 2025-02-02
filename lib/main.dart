import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'utils/routes.dart'; 
void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
    await Firebase.initializeApp( 
        options: DefaultFirebaseOptions.currentPlatform, 
        ); 
    runApp(MyApp()); 

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        AppRoutes.LOGIN : (context) => LoginScreen(),
        AppRoutes.REGISTER : (context) => RegisterScreen(),
        AppRoutes.HOME : (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

