// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signagestor/components/routes/views/register.dart';
import 'package:signagestor/components/routes/views/subir_docentes.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/helper_functions.dart';
import 'package:signagestor/tools/loading_indicator.dart';

class Login extends StatefulWidget {
  static const String routname = '/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void Ingreso() async {
    var pref = PreferencesUser();
    LoadingScreen().show(context);

    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (context.mounted) {
        var uid = userCredential.user?.uid;
        pref.uid = uid!;
        final DocumentSnapshot tipoSnapshot =
            await FirebaseFirestore.instance.collection('Users').doc(uid).get();
        pref.photoPerfil = tipoSnapshot['fotoPerfil'];
        if (tipoSnapshot['tipo'] == 'Alcaldia') {
          LoadingScreen().hide();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Register()),
          );
        } else if (tipoSnapshot['tipo'] == 'Administrador') {
          LoadingScreen().hide();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SubirDocentes()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      LoadingScreen().hide();
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08ADE5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100.2,
                ),
                SizedBox(
                  child: Image.asset(
                    'assets/name.png',
                    width: 260.8,
                    height: 50.5,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 200.2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'USUARIO:',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA2A1A6),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA2A1A6),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA2A1A6),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F1F1),
                      ),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      obscureText: false,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CONTRASEÑA:',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA2A1A6),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA2A1A6),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFA2A1A6),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F1F1),
                      ),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      obscureText: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Ingreso();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        color: const Color(0xFF1F85C0),
                        borderRadius: BorderRadius.circular(18)),
                    child: const Center(
                      child: Text(
                        'Ingresar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/logo_prodislima.png',
                      fit: BoxFit.contain,
                      width: 65.3,
                      height: 65.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
