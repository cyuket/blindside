import 'package:blindside/app/app.dart';
import 'package:blindside/bootstrap.dart';
import 'package:blindside/core/injections/locator.dart';
import 'package:blindside/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependecies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await bootstrap(() => const App());
}
