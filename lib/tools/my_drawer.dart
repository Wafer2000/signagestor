// ignore_for_file: use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signagestor/components/routes/log/login.dart';
import 'package:signagestor/components/routes/views/profile.dart';
import 'package:signagestor/components/routes/views/register.dart';
import 'package:signagestor/components/routes/views/registrado.dart';
import 'package:signagestor/components/routes/views/subir_docentes.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/loading_indicator.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final pref = PreferencesUser();

  final TextEditingController _textController = TextEditingController();

  Future<void> _signOut() async {
    var pref = PreferencesUser();
    LoadingScreen().show(context);

    try {
      await FirebaseAuth.instance.signOut();
      pref.uid = '';
      pref.photoPerfil = '';
      LoadingScreen().hide();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(pref.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const AlertDialog(
              title: Text('Algo salio mal'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          if (snapshot.data == null) {
            return const Text('No hay datos');
          }
          final user = snapshot.data!;
          return Drawer(
            shadowColor: const Color(0xFFFFFFFF),
            surfaceTintColor: const Color(0xFFFFFFFF),
            backgroundColor: const Color(0xFF08ADE5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: user['fotoPerfil'] == ''
                            ? Image.asset(
                                'assets/user.png',
                                width: 200,
                                height: 200,
                                errorBuilder: (context, error, stackTrace) {
                                  return IconButton(
                                    highlightColor: Colors.transparent,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/user.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                  );
                                },
                              )
                            : Image.network(
                                user['fotoPerfil'],
                                width: 200,
                                height: 200,
                                errorBuilder: (context, error, stackTrace) {
                                  return IconButton(
                                    highlightColor: Colors.transparent,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/user.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                  );
                                },
                              ),
                    ),
                    if (user['tipo'] == 'Administrador')
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: ListTile(
                          title: const Text(
                            'Subir',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, SubirDocentes.routname);
                          },
                        ),
                      ),
                    if (user['tipo'] == 'Alcaldia')
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: ListTile(
                          title: const Text(
                            'Registro',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Register.routname);
                          },
                        ),
                      ),
                    if (user['tipo'] == 'Alcaldia')
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: ListTile(
                          title: const Text(
                            'Registrado',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Registrado.routname);
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: ListTile(
                        title: const Text(
                          'Perfil',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, Profile.routname);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, bottom: 25),
                  child: ListTile(
                    title: const Text(
                      'Cerrar Sesion',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onTap: () {
                      _signOut();
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
