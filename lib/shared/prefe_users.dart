import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signagestor/firebase/firebase_options.dart';

class PreferencesUser {
  static late SharedPreferences _prefs;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _prefs = await SharedPreferences.getInstance();
  }

  String get uid {
    return _prefs.getString('uid') ?? '';
  }

  set uid(String value) {
    _prefs.setString('uid', value);
  }

  String get ultimateTipe {
    return _prefs.getString('ultimateTipe') ?? '';
  }

  set ultimateTipe(String value) {
    _prefs.setString('ultimateTipe', value);
  }

  String get listId {
    return _prefs.getString('listId') ?? '';
  }

  set listId(String value) {
    _prefs.setString('listId', value);
  }

  String get subjectId {
    return _prefs.getString('subjectId') ?? '';
  }

  set subjectId(String value) {
    _prefs.setString('subjectId', value);
  }

  String get photoPerfil {
    return _prefs.getString('photoPerfil') ?? '';
  }

  set photoPerfil(String value) {
    _prefs.setString('photoPerfil', value);
  }

  String get firma {
    return _prefs.getString('firma') ?? '';
  }

  set firma(String value) {
    _prefs.setString('firma', value);
  }

  String get foto {
    return _prefs.getString('foto') ?? '';
  }

  set foto(String value) {
    _prefs.setString('foto', value);
  }
}