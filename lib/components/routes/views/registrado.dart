import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/my_drawer.dart';

class Registrado extends StatefulWidget {
  static const String routname = '/registrado';
  const Registrado({super.key});

  @override
  State<Registrado> createState() => _RegistradoState();
}

class _RegistradoState extends State<Registrado> {
  final pref = PreferencesUser();
  final List<bool> _infoList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            child: Text(
          'REGISTRADO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        actions: const [
          SizedBox(
            width: 48,
          )
        ],
        backgroundColor: const Color(0xFF41C1F8),
      ),
      drawer: const MyDrawer(),
            backgroundColor: Colors.grey.shade300,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(pref.uid)
              .collection('Registrado')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar los datos'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text('No se encontraron datos'),
              );
            }

            final service = snapshot.data?.docs;

            if (service == null) {
              return const Center(
                child: Text('No se encontraron datos'),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: service.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = service[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  //String docID = document.id;
                  
                  if (_infoList.length <= index) {
                    _infoList.add(false);
                  }
                  if (_infoList[index]) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFA2A1A6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFEDE9E9),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start, // Add this line
                                children: [
                                  const SizedBox(
                                    width: 56,
                                  ),
                                  data['foto'] != ''
                                      ? SizedBox(
                                          height: 131.2,
                                          width: 131.2,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              data['foto'],
                                            ),
                                            radius: 15,
                                          ),
                                        )
                                      : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                child: Image.asset(
                                                  'assets/user.png',
                                                  width: 131.2,
                                                  height: 131.2,
                                                ),
                                              ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                      child: IconButton(
                                        icon: _infoList[index]
                                            ? const Icon(
                                                Icons.keyboard_arrow_up)
                                            : const Icon(
                                                Icons.keyboard_arrow_down),
                                        onPressed: () {
                                          setState(() {
                                            _infoList[index] =
                                                !_infoList[index];
                                          });
                                        },
                                        iconSize: 35,
                                        tooltip: 'Informacion',
                                        color: const Color(0xFF676767),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data['nombres']} ${data['apellidos']}'
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Cedula: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                        Text(
                                          '${data['cedula']}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Correo: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                        Text(
                                          '${data['correo']}',
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Firma: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    child: Container(
                                      width: 363.7,
                                      height: 74.6,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF949494),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                      child: Center(
                                          child: Transform.rotate(
                                        angle: pi / 2,
                                        child: Image.memory(
                                          base64Decode(data['firma']),
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${data['nombres']} ${data['apellidos']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 27,
                                                  color: Color(0xFF676767),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'CC ${data['cedula']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF676767),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: _infoList[index]
                                            ? const Icon(
                                                Icons.keyboard_arrow_up)
                                            : const Icon(
                                                Icons.keyboard_arrow_down),
                                        onPressed: () {
                                          setState(() {
                                            _infoList[index] =
                                                !_infoList[index];
                                          });
                                        },
                                        iconSize: 35,
                                        tooltip: 'Informacion',
                                        color: const Color(0xFF676767),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 10,
                                thickness: 1,
                                color: Color(0xFF676767),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          }),
    );
  }
}
