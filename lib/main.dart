import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/ui.dart';

import 'constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}
