import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:signagestor/components/routes.dart';
import 'package:signagestor/firebase/firebase_options.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/style/theme/dark.dart';
import 'package:signagestor/style/theme/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesUser.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await Future.delayed(Duration(milliseconds: (5610).round()));
    FlutterNativeSplash.remove();
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Routes(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
