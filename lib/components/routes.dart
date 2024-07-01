// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signagestor/components/routes/log/login.dart';
import 'package:signagestor/components/routes/views/firma.dart';
import 'package:signagestor/components/routes/views/registered.dart';
import 'package:signagestor/components/routes/views/registrado.dart';
import 'package:signagestor/components/routes/views/subir_docentes.dart';
import 'package:signagestor/components/routes/views/register.dart';
import 'package:signagestor/components/routes/views/profile.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/style/theme/dark.dart';
import 'package:signagestor/style/theme/light.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final prefs = PreferencesUser();

  Future<Object?> User(uid) async {
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    if (user.exists) {
      final data = user.data();
      print('Document data: $data');
      return data;
    } else {
      print('Document does not exist');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = prefs.uid;
    if (uid != null && uid != '') {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('Users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasError) {
            return const AlertDialog(
              title: Text('Algo salio mal'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF41C1F8),
              ),
            );
          }
          if (snapshot.data == null) {
            return const Text('No hay datos');
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: data!['tipo'] == 'Administrador'
                ? SubirDocentes.routname
                : Register.routname,
            routes: {
              Login.routname: (context) => const Login(),
              Firma.routname: (context) => const Firma(),
              Profile.routname: (context) => const Profile(),
              Register.routname: (context) => const Register(),
              Registrado.routname: (context) => const Registrado(),
              Registered.routname: (context) => const Registered(),
              SubirDocentes.routname: (context) => const SubirDocentes(),
            },
            theme: lightMode,
            darkTheme: darkMode,
          );
        },
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Login.routname,
        routes: {
          Login.routname: (context) => const Login(),
          Firma.routname: (context) => const Firma(),
          Profile.routname: (context) => const Profile(),
          Register.routname: (context) => const Register(),
          Registrado.routname: (context) => const Registrado(),
          Registered.routname: (context) => const Registered(),
          SubirDocentes.routname: (context) => const SubirDocentes(),
        },
        theme: lightMode,
        darkTheme: darkMode,
      );
    }
  }
}
