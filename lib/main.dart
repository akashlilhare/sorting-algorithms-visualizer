
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/input_bloc/input_bloc.dart';
import 'bloc/theme_bloc/theme_bloc.dart';
import 'pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
storageDirectory:(kIsWeb) ?
window.localStorage['mypref']
   :
  await getTemporaryDirectory()

    //storageDirectory:Plt.Platform.isAndroid? await getTemporaryDirectory():window.localStorage['mypref'],
  );
  runApp(Wrapper());
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: InputBloc()),
        BlocProvider.value(value: ThemeBloc()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (BuildContext context, ThemeMode themeMode) {
        return MaterialApp(
          title: 'Sorting Visualizer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            iconTheme: IconThemeData(
              color: Colors.grey.shade800,
            ),
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.blueAccent,
            buttonColor: Colors.blueAccent,
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
          ),
          themeMode: themeMode,
          home: HomePage(),
        );
      },
    );
  }
}
