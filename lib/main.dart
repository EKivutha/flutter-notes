import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_frog/api/api.dart';
import 'package:notes_app_frog/main/bloc.dart';

import 'homepage.dart';

void main() => runApp(MyApp(nApiClient: ApiClient.create()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.nApiClient}) : super(key: key);
  final ApiClient nApiClient;
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.amber),
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              home: BlocProvider(
                create: (_) => NBloc(
                  nApiClient: nApiClient,
                )..add(FetchStarted()),
                child: const HomePage(),
              ));
        });
  }
}
