// ignore_for_file: avoid_print, use_build_context_synchronously, unnecessary_new, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signagestor/tools/helper_functions.dart';
import 'package:signagestor/tools/loading_indicator.dart';
import 'package:signagestor/tools/my_drawer.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'dart:convert';

class SubirDocentes extends StatefulWidget {
  static const String routname = '/subir_docentes';
  const SubirDocentes({super.key});

  @override
  State<SubirDocentes> createState() => _AdminState();
}

class _AdminState extends State<SubirDocentes> {
  String text = "";
  int count = 0;
  int countpro = 0;
  final db = FirebaseFirestore.instance;
  final WriteBatch batch = FirebaseFirestore.instance.batch();
  final TextEditingController alcaldiaController = TextEditingController();
  late String alcaldiaId = '';
  List<String>? _dropDownItems = [];

  void registrar(id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(id)
                    .collection('Registrar')
                    .snapshots(),
                builder: (context, snapshot) {
                  final service = snapshot.data?.docs;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Scaffold(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      body: const Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                'No hay Datos',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Faltantes por Registrar',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () async {
                              final DocumentSnapshot docenteSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(id)
                                      .get();

                              print(service);

                              if (service != null) {
                                int rowNumber = 0;
                                final csvData = [
                                  'FALTANTES POR REGISTRAR',
                                  'Alcaldia: ${docenteSnapshot['municipio']}',
                                  'Nº,Cedula,Nombres,Apellidos,Correo Electronico',
                                  ...service.asMap().entries.where((entry) {
                                    Map<String, dynamic> data = entry.value
                                        .data() as Map<String, dynamic>;
                                    return data['programa'] != 'Programa';
                                  }).map((entry) {
                                    Map<String, dynamic> data = entry.value
                                        .data() as Map<String, dynamic>;
                                    rowNumber++;
                                    return [
                                      '$rowNumber',
                                      data['cedula'],
                                      '${data['nombres'].replaceAll(',', ',')}',
                                      '${data['apellidos'].replaceAll(',', ',')}',
                                      '${data['correo'].replaceAll(',', ',')}',
                                    ].join(',');
                                  }),
                                ].join('\n');

                                final now = DateTime.now();
                                final hcreacion =
                                    DateFormat('HH:mm:ss').format(now);
                                final fcreacion =
                                    DateFormat('dd-MM-yyyy').format(now);

                                final directory =
                                    await getExternalStorageDirectory();
                                final appDocumentsDir = Directory(
                                    '${directory!.path}/Documents/Faltante_SignaGestor');
                                if (!appDocumentsDir.existsSync()) {
                                  appDocumentsDir.createSync(recursive: true);
                                }

                                final file = File(
                                    '${appDocumentsDir.path}/Faltantes_${hcreacion}_$fcreacion.csv');
                                await file.writeAsString(csvData,
                                    encoding: utf8);

                                Navigator.of(context).pop();
                                LoadingScreen().hide();
                                displayMessageToUser(
                                    'Excel se guardo en la ruta: ${file.path}',
                                    context);
                                print(file.path);
                              } else {
                                Navigator.of(context).pop();
                                LoadingScreen().hide();
                                displayMessageToUser(
                                    'No data to export', context);
                              }
                            },
                            child: const Text(
                              'Exportar a Excel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Nº',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Cedula',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Nombres',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Apellidos',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Correo Electronico',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              rows: service!.asMap().entries.map((entry) {
                                Map<String, dynamic> data =
                                    entry.value.data() as Map<String, dynamic>;
                                //String docId = entry.value.id;
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('${entry.key + 1}')),
                                    DataCell(Text('${data['cedula']}')),
                                    DataCell(Text('${data['nombres']}')),
                                    DataCell(Text('${data['apellidos']}')),
                                    DataCell(Text('${data['correo']}')),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }

  void registrado(id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(id)
                    .collection('Registrado')
                    .snapshots(),
                builder: (context, snapshot) {
                  final service = snapshot.data?.docs;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  if (snapshot.data == null) {
                    return Scaffold(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      body: const Stack(
                        children: [
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                'No hay Datos',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            'Registrados',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            onPressed: () async {
                              final DocumentSnapshot docenteSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(id)
                                      .get();

                              print(service);

                              if (service != null) {
                                int rowNumber = 0;
                                final csvData = [
                                  'REGISTRADOS POR REGISTRAR',
                                  'Alcaldia: ${docenteSnapshot['municipio']}',
                                  'Nº,Cedula,Nombres,Apellidos,Correo Electronico,Link Foto,Link Firma',
                                  ...service.asMap().entries.where((entry) {
                                    Map<String, dynamic> data = entry.value
                                        .data() as Map<String, dynamic>;
                                    return data['programa'] != 'Programa';
                                  }).map((entry) {
                                    Map<String, dynamic> data = entry.value
                                        .data() as Map<String, dynamic>;
                                    rowNumber++;
                                    return [
                                      '$rowNumber',
                                      data['cedula'],
                                      '${data['nombres'].replaceAll(',', ',')}',
                                      '${data['apellidos'].replaceAll(',', ',')}',
                                      '${data['correo'].replaceAll(',', ',')}',
                                      '${data['foto'].replaceAll(',', ',')}',
                                      '${data['firma'].replaceAll(',', ',')}',
                                    ].join(',');
                                  }),
                                ].join('\n');

                                final now = DateTime.now();
                                final hcreacion =
                                    DateFormat('HH:mm:ss').format(now);
                                final fcreacion =
                                    DateFormat('dd-MM-yyyy').format(now);

                                final directory =
                                    await getExternalStorageDirectory();
                                final appDocumentsDir = Directory(
                                    '${directory!.path}/Documents/Faltante_SignaGestor');
                                if (!appDocumentsDir.existsSync()) {
                                  appDocumentsDir.createSync(recursive: true);
                                }

                                final file = File(
                                    '${appDocumentsDir.path}/Faltantes_${hcreacion}_$fcreacion.csv');
                                await file.writeAsString(csvData,
                                    encoding: utf8);

                                Navigator.of(context).pop();
                                LoadingScreen().hide();
                                displayMessageToUser(
                                    'Excel se guardo en la ruta: ${file.path}',
                                    context);
                                print(file.path);
                              } else {
                                Navigator.of(context).pop();
                                LoadingScreen().hide();
                                displayMessageToUser(
                                    'No data to export', context);
                              }
                            },
                            child: const Text(
                              'Exportar a Excel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Nº',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Cedula',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Nombres',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Apellidos',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Correo Electronico',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Link Foto',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Link Firma',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                              rows: service!.asMap().entries.map((entry) {
                                Map<String, dynamic> data =
                                    entry.value.data() as Map<String, dynamic>;
                                //String docId = entry.value.id;
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('${entry.key + 1}')),
                                    DataCell(Text('${data['cedula']}')),
                                    DataCell(Text('${data['nombres']}')),
                                    DataCell(Text('${data['apellidos']}')),
                                    DataCell(Text('${data['correo']}')),
                                    DataCell(Text('${data['foto']}')),
                                    DataCell(Text('${data['firma']}')),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }

  Future<void> createData(List excel, WriteBatch batch) async {
    final cedula = excel[0].toString().split('.')[0];
    batch.set(
        db
            .collection("Users")
            .doc(alcaldiaId)
            .collection('Registrar')
            .doc('${int.parse(cedula)}'),
        {
          'cedula': '${excel[0]}',
          'nombres': '${excel[1]}',
          'apellidos': '${excel[2]}',
          'correo': '${excel[3]}',
          'foto': '',
          'firma': '',
        });
  }

  void _openfile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result == null) return;

    final pickedFile = result.files.first;
    final path = pickedFile.path!;

    if (path.endsWith('.csv')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se permiten archivos CSV'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).pop();
      return;
    }

    var bytes = File(path).readAsBytesSync();
    var decoder = new SpreadsheetDecoder.decodeBytes(bytes, update: true);

    // Create a new batch for each XLSX file
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    LoadingScreen().show(context);

    for (var table in decoder.tables.keys) {
      print(table);
      print(decoder.tables[table]?.maxCols);
      print(decoder.tables[table]?.maxRows);
      print(decoder.tables[table]?.rows);
      setState(() {
        text = decoder.tables[table]!.rows.toString();
      });
      for (var row in decoder.tables[table]!.rows) {
        row[0] == "Cédula" ? print("") : createData(row, batch);
      }

      // Commit the batch after adding all the documents for the current file
      await batch.commit();
    }
    LoadingScreen().hide();
    alcaldiaController.clear();
    displayMessageToUser('Se han subido los docentes', context);
    count = 0;
  }

  void _subir_docentes() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Docentes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .where('municipio', isNotEqualTo: 'Todos')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasError) {
                            print('Error: ${snapshot.error}');
                            return const CircularProgressIndicator();
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          _dropDownItems = snapshot.data!.docs
                              .map((doc) => '${doc['municipio']}')
                              .cast<String>()
                              .toList();

                          return DropdownButtonFormField<String>(
                            value: alcaldiaController.text.isNotEmpty
                                ? alcaldiaController.text
                                : null,
                            items: _dropDownItems?.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              final DocumentSnapshot<Map<String, dynamic>> doc =
                                  snapshot.data!.docs.firstWhere(
                                      (doc) => '${doc['municipio']}' == value);
                              final String docId = doc.id;
                              setState(() {
                                alcaldiaId = docId;
                                print(docId);
                                alcaldiaController.text = value!;
                              });
                            },
                            icon: const Icon(Icons.arrow_drop_down),
                            decoration: InputDecoration(
                              labelText: 'Alcaldia',
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
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _openfile();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: const Color(0xFF1F85C0),
                              borderRadius: BorderRadius.circular(18)),
                          child: const Center(
                            child: Text(
                              'Subir',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('municipio', isNotEqualTo: 'Todos')
            .snapshots(),
        builder: (context, snapshot) {
          final service = snapshot.data?.docs;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF41C1F8),
              ),
            );
          }
          if (snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Center(child: Text('Subir Docentes')),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: () {
                      _subir_docentes();
                    },
                    tooltip: 'Add',
                    alignment: Alignment.center,
                  ),
                ],
                backgroundColor: const Color(0xFF41C1F8),
              ),
              drawer: const MyDrawer(),
            backgroundColor: Colors.grey.shade300,
              body: const Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        'No hay Datos',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Center(child: Text('Subir Docentes')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.file_upload),
                  onPressed: () {
                    _subir_docentes();
                  },
                  tooltip: 'Add',
                  alignment: Alignment.center,
                ),
              ],
              backgroundColor: const Color(0xFF41C1F8),
            ),
            drawer: const MyDrawer(),
            backgroundColor: Colors.grey.shade300,
            body: Expanded(
              child: ListView.builder(
                itemCount: service?.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = service![index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String docID = document.id;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 15),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Alcaldia: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              data['municipio'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Correo: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              data['email'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.black,
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
                                      icon: const Icon(Icons.pending_actions),
                                      onPressed: () {
                                        registrar(docID);
                                      },
                                      iconSize: 35,
                                      tooltip: 'Registrar',
                                      color: Colors.grey,
                                      alignment: Alignment.center,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.check_circle),
                                      onPressed: () {
                                        registrado(docID);
                                      },
                                      iconSize: 35,
                                      tooltip: 'Abono',
                                      color: Colors.grey,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              height: 10,
                              thickness: 1,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
