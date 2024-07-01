// ignore_for_file: unnecessary_null_comparison, avoid_print, use_build_context_synchronously, unused_element, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signagestor/components/routes/views/registered.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/my_drawer.dart';

class Register extends StatefulWidget {
  static const String routname = '/register';
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final pref = PreferencesUser();
  final List<bool> _infoList = [];
  var searchName = "";
  bool button = false;
  String filterBy = "nombres";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: button == false
            ? const Center(
                child: Text(
                'REGISTRO',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
            : TextField(
                onChanged: (value) {
                  setState(() {
                    searchName = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  hintText: 'Buscar Docente...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list),
                    onSelected: (value) {
                      setState(() {
                        filterBy = value;
                      });
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'nombres',
                        child: Text('Nombres'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'apellidos',
                        child: Text('Apellidos'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'cedula',
                        child: Text('Cédula'),
                      ),
                    ],
                  ),
                ),
              ),
        actions: [
          IconButton(
            icon: button == false
                ? const Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                searchName = '';
                if (button == false) {
                  button = true;
                } else {
                  button = false;
                }
              });
            },
          ),
        ],
        backgroundColor: const Color(0xFF41C1F8),
      ),
      drawer: const MyDrawer(),
            backgroundColor: Colors.grey.shade300,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(pref.uid)
                  .collection('Registrar')
                  .orderBy(filterBy)
                  .startAt([searchName]).endAt(
                      ["$searchName\uf8ff"]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar los datos'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text(''),
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
                  String docID = document.id;

                  // Initialize the boolean value for this list item
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
                                  Image.network(
                                    data['foto'],
                                    fit: BoxFit.cover,
                                    height: 131.2,
                                    errorBuilder: (context, error, stackTrace) {
                                      return IconButton(
                                        highlightColor: Colors.transparent,
                                        onPressed: () {},
                                        icon: Image.asset(
                                          'assets/user.png',
                                          fit: BoxFit.cover,
                                          height: 131.2,
                                        ),
                                      );
                                    },
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
                                        child: data['foto'] == ''
                                            ? const Text(
                                                'Firma No Registrada',
                                                style: TextStyle(
                                                    color: Color(0xFFA2A1A6),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            : data['foto'],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        pref.listId = docID;
                                        pref.firma = '';
                                        pref.foto = '';
                                        Navigator.pushNamed(
                                            context, Registered.routname);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.04,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF1F85C0),
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: const Center(
                                          child: Text(
                                            'Registrar Informacion',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
