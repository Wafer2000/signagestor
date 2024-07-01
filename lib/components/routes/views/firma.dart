// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:signagestor/components/routes/views/registered.dart';
import 'package:signagestor/shared/prefe_users.dart';
import 'package:signagestor/tools/helper_functions.dart';
import 'package:signature/signature.dart';

class Firma extends StatefulWidget {
  static const String routname = '/firma';
  const Firma({super.key});

  @override
  State<Firma> createState() => _FirmaState();
}

class _FirmaState extends State<Firma> {
  final pref = PreferencesUser();
  SignatureController firmaController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 4,
    exportPenColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void dispose() {
    firmaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF949494),
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: Signature(
                controller: firmaController,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 2,
                backgroundColor: Colors.white,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: GestureDetector(
                      onTap: () async {
                        final firmaBytes = await firmaController.toPngBytes();
                        if (firmaBytes != null) {
                          final base64String = base64Encode(firmaBytes);
                          pref.firma = base64String;
                          displayMessageToUser('Se adjunto la firma', context);
                          Navigator.pushNamed(context, Registered.routname);
                        } else {
                          displayMessageToUser('Debes firmar', context);
                        }
                      },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1EAD68),
                            borderRadius: BorderRadius.circular(18)),
                        child: const Center(
                          child: Text(
                            'Guardar',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: GestureDetector(
                      onTap: () async {
                        pref.firma = '';
                        firmaController.clear();
                      },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFF1F85C0),
                            borderRadius: BorderRadius.circular(18)),
                        child: const Center(
                          child: Text(
                            'Rehacer',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: GestureDetector(
                      onTap: () async {
                        displayMessageToUser('No se adjunto la firma', context);
                        pref.firma = '';
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xFFBE4545),
                            borderRadius: BorderRadius.circular(18)),
                        child: const Center(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
