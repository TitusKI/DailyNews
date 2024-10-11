import 'package:daily_news/config/routes/pages.dart';
import 'package:daily_news/config/theme/app_theme.dart';
import 'package:daily_news/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final AppPages appPages = const AppPages();
  const MyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...appPages.allBlocProvider(context)],
      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appPages.generateRouteSettings,
      ),
    );
  }
}
