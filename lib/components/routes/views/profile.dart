// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/my_drawer.dart';

class Profile extends StatefulWidget {
  static const String routname = '/profile';
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _pref = PreferencesUser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Center(child: Text('P e r f i l')),
          actions: const [
            SizedBox(width: 56,)
          ],
        backgroundColor: const Color(0xFF41C1F8),
        ),
        drawer: const MyDrawer(),
            backgroundColor: Colors.grey.shade300,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(_pref.uid)
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

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: user['fotoPerfil'] == ''
                            ? Image.asset(
                                'assets/user.png',
                                width: 250,
                                height: 250,
                                errorBuilder: (context, error, stackTrace) {
                                  return IconButton(
                                    highlightColor: Colors.transparent,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/user.png',
                                      width: 250,
                                      height: 250,
                                    ),
                                  );
                                },
                              )
                            : Image.network(
                                user['fotoPerfil'],
                                width: 250,
                                height: 250,
                                errorBuilder: (context, error, stackTrace) {
                                  return IconButton(
                                    highlightColor: Colors.transparent,
                                    onPressed: () {},
                                    icon: Image.asset(
                                      'assets/user.png',
                                      width: 250,
                                      height: 250,
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${user['departamento']}, ${user['municipio']}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF676767)),
                      ),
                      Text(
                        user['email'],
                        style: const TextStyle(color: Color(0xFF676767)),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Tipo: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF676767)),
                          ),
                          Text(
                            '${user['tipo']}',
                            style: const TextStyle(fontSize: 20, color: Color(0xFF676767)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
