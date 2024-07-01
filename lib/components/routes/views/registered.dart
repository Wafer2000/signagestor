// ignore_for_file: unused_element, unnecessary_null_comparison, use_build_context_synchronously, avoid_print, unnecessary_cast

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signagestor/components/routes/views/firma.dart';
import 'package:signagestor/components/routes/views/register.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/helper_functions.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
import 'package:signagestor/tools/loading_indicator.dart';

class Registered extends StatefulWidget {
  static const String routname = '/registered';
  const Registered({super.key});

  @override
  State<Registered> createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  final pref = PreferencesUser();
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UploadTask? _uploadTask;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  Future uploadFile() async {
    setState(() {});
    LoadingScreen().show(context);

    final DocumentSnapshot docenteSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(pref.uid)
        .collection('Registrar')
        .doc(pref.listId)
        .get();

    final DocumentSnapshot alcaldiaSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(pref.uid)
        .get();

    final path =
        'Fotos de Docentes/Alcaldia de ${alcaldiaSnapshot['municipio']}/${docenteSnapshot['cedula']}';
    final file = File(pref.foto);
    final ref = FirebaseStorage.instance.ref().child(path);

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    setState(() {
      _uploadTask = ref.putFile(file, metadata);
    });

    final snapshot = await _uploadTask!.whenComplete(() {});

    final urlDowload = await snapshot.ref.getDownloadURL();
    print('Dowload link: $urlDowload');

    if (urlDowload != null) {
      if (docenteSnapshot.exists) {
        final pdf = pw.Document();

        List<pw.Widget> pdfWidgets = [];
        final image = (await rootBundle
                .load("assets/${alcaldiaSnapshot['municipio']}.png"))
            .buffer
            .asUint8List();
        final escudoArea = pw.Container(
            padding: const pw.EdgeInsets.all(10),
            height: 60,
            color: PdfColor.fromHex("#aaddfbd9"),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Image(pw.MemoryImage(image),
                      width: 40, height: 40, fit: pw.BoxFit.cover),
                  pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                                "Bono de la Alcaldia de ${alcaldiaSnapshot['municipio']}",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Text("Generado por SignaGestor",
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#666"),
                                    fontSize: 10))
                          ]))
                ]));
        final gap30 = pw.SizedBox(height: 30);
        final datosDocenteArea = pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                  child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      height: 70,
                      decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColor.fromHex("#f0f0f0")),
                      ),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Nombres",
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#666"),
                                    fontSize: 10)),
                            pw.Text("${docenteSnapshot['nombres']}",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ]))),
              pw.Expanded(
                  child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      height: 70,
                      decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColor.fromHex("#f0f0f0")),
                      ),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Apellidos",
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#666"),
                                    fontSize: 10)),
                            pw.Text("${docenteSnapshot['apellidos']}",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ]))),
              pw.Expanded(
                  child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      height: 70,
                      decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColor.fromHex("#f0f0f0")),
                      ),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Cedula",
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#666"),
                                    fontSize: 10)),
                            pw.Text("${docenteSnapshot['cedula']}",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ]))),
              pw.Expanded(
                  child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      height: 70,
                      decoration: pw.BoxDecoration(
                        border:
                            pw.Border.all(color: PdfColor.fromHex("#f0f0f0")),
                      ),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Correo",
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#666"),
                                    fontSize: 10)),
                            pw.Text("${docenteSnapshot['correo']}",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold)),
                          ]))),
            ]);
        final gap500 = pw.SizedBox(height: 500);
        final firmas = pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text("Firma Alcaldia: ",
                    style: pw.TextStyle(
                        color: PdfColor.fromHex("#666"), fontSize: 15)),
                pw.Transform.rotate(
                  angle: pi / 2,
                  child: pw.Image(
                      pw.MemoryImage(
                        base64Decode(pref.firma),
                        dpi: 250,
                      ),
                      width: 250,
                      height: 125,
                      alignment: pw.Alignment.centerRight),
                ),
              ],
            ),
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text("Firma Docente: ",
                    style: pw.TextStyle(
                        color: PdfColor.fromHex("#666"), fontSize: 15)),
                pw.Transform.rotate(
                  angle: pi / 2,
                  child: pw.Image(
                      pw.MemoryImage(
                        base64Decode(pref.firma),
                        dpi: 250,
                      ),
                      width: 250,
                      height: 125,
                      alignment: pw.Alignment.centerRight),
                ),
              ],
            ),
          ],
        );
        pdfWidgets.add(escudoArea);
        pdfWidgets.add(gap30);
        pdfWidgets.add(datosDocenteArea);
        pdfWidgets.add(gap500);
        pdfWidgets.add(firmas);
        pdf.addPage(pw.MultiPage(
            pageFormat: PdfPageFormat.a3,
            build: (pw.Context context) {
              return pdfWidgets;
            }));

        final pdfSaved = await pdf.save();

        final directory = await getApplicationDocumentsDirectory();
        final pdfDirectory = Directory('${directory.path}/PDFs');
        if (!pdfDirectory.existsSync()) {
          pdfDirectory.createSync();
        }
        final file =
            File('${pdfDirectory.path}/${docenteSnapshot['cedula']}.pdf');
        await file.writeAsBytes(pdfSaved);

        final storageRef = await FirebaseStorage.instance
            .ref('PDFs/${docenteSnapshot['cedula']}.pdf')
            .putFile(file);
        final snapshot = storageRef;
        final urlPdf = await snapshot.ref.getDownloadURL();

        final Dio dio = Dio();

        await dio.post('https://api.emailjs.com/api/v1.0/email/send', data: {
          "service_id": "service_ysryach",
          "template_id": "template_u9v8ibu",
          "user_id": "ZgMZ7ANMB78G2HFyo",
          "accessToken": "NRB6uaeMbisvu7ElcLAeG",
          "template_params": {
            "from_name": "Bono de Prodislima",
            "to_name":
                "${alcaldiaSnapshot['tipo']} ${alcaldiaSnapshot['municipio']}",
            "message": "nuevo link: $urlPdf",
            "email_to": "mariofernandogonsalvez@gmail.com",
            "teacher":
                "${docenteSnapshot['nombres']} ${docenteSnapshot['apellidos']}"
          }
        });

        await _firestore
            .collection('Users')
            .doc(pref.uid)
            .collection('Registrado')
            .doc(pref.listId)
            .set({
          'apellidos': docenteSnapshot['apellidos'],
          'cedula': docenteSnapshot['cedula'],
          'correo': docenteSnapshot['correo'],
          'firma': pref.firma,
          'foto': urlDowload,
          'nombres': docenteSnapshot['nombres'],
          'pdf': urlPdf
        });
        displayMessageToUser('Se subio el documento', context);
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(pref.uid)
            .collection('Registrar')
            .doc(pref.listId)
            .delete();
        displayMessageToUser('Se subio correctamente', context);
        LoadingScreen().hide();
        Navigator.pushReplacementNamed(context, Register.routname);
      } else {
        displayMessageToUser('No existe este docente', context);
        LoadingScreen().hide();
        Navigator.pushReplacementNamed(context, Register.routname);
      }
    }
    setState(() {
      _uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            child: Text(
          'REGISTRO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            setState(() {
              pref.firma = '';
              pref.foto = '';
              pref.listId = '';
              _selectedImage = null;
            });
            Navigator.pushNamed(context, Register.routname);
          },
        ),
        actions: const [
          SizedBox(
            width: 48,
          )
        ],
        backgroundColor: const Color(0xFF41C1F8),
      ),
            backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      border: Border.all(
                                        color: Colors.black, // Color del borde
                                        width: 1, // Ancho del borde
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        pref.foto != ''
                                            ? SizedBox(
                                                width: 186.6,
                                                height: 186.6,
                                                child: CircleAvatar(
                                                  backgroundImage: FileImage(
                                                      File(pref.foto)),
                                                  radius: 15,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                child: Image.asset(
                                                  'assets/user.png',
                                                  width: 186.6,
                                                  height: 186.6,
                                                ),
                                              ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF41C1F8),
                                              ),
                                              child: IconButton(
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(pref.foto != ''
                                                    ? Icons.delete
                                                    : Icons
                                                        .camera_alt_outlined),
                                                onPressed: () async {
                                                  if (_selectedImage != null) {
                                                    setState(() {
                                                      _selectedImage = null;
                                                    });
                                                  } else {
                                                    final XFile? image =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    if (image != null) {
                                                      setState(() {
                                                        _selectedImage =
                                                            File(image.path);
                                                        pref.foto =
                                                            _selectedImage!
                                                                .path;
                                                      });
                                                    }
                                                  }
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: SizedBox(
                                width: 500,
                                height: 130,
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      height: 94.6,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF949494),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                      child: Center(
                                        child: pref.firma.isEmpty
                                            ? const Text('Firma No Registrada', style: TextStyle(color: Color(0xFF676767)),)
                                            : Transform.rotate(
                                                angle: pi / 2,
                                                child: Image.memory(
                                                  base64Decode(pref.firma),
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF41C1F8),
                                        ),
                                        child: IconButton(
                                          iconSize: 30,
                                          color: Colors.white,
                                          icon: const Icon(Icons.edit),
                                          onPressed: () async {
                                            Navigator.pushNamed(
                                                context, Firma.routname);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF14B4B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      pref.firma = '';
                      _selectedImage = null;
                    });
                    Navigator.pushReplacementNamed(context, Register.routname);
                  },
                  child: const Text('CANCELAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1EAD68),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () async {
                    //Guardar
                    if (pref.foto != null && pref.firma != '') {
                      uploadFile();
                    } else {
                      displayMessageToUser(
                          'Debes firmar y tomar la foto obligatoriamente',
                          context);
                    }
                  },
                  child: const Text('GUARDAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
