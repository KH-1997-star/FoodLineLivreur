// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/screens/command_list_screen.dart';
import 'package:food_line_livreur/screens/conexion_screen.dart';
import 'package:food_line_livreur/screens/create_account_screen.dart';
import 'package:food_line_livreur/screens/detail_command.dart';
import 'package:food_line_livreur/screens/forget_password_one_screen.dart';
import 'package:food_line_livreur/screens/forget_password_second_screen.dart';
import 'package:food_line_livreur/screens/home_screen.dart';
import 'package:food_line_livreur/screens/location_screen.dart';
import 'package:food_line_livreur/screens/profile/profile_screen.dart';
import 'package:food_line_livreur/screens/qr_code_screen.dart';
import 'package:food_line_livreur/utils/my_theme_data.dart';

void main() {
  //hello
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 840),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: myThemeData,
              initialRoute: '/conexion_screen',
              routes: {
                '/conexion_screen': (context) => const ConexionScreen(),
                '/create_account_screen': (context) =>
                    const CreateAccountScreen(),
                '/home_screen': (context) => const HomeScreen(),
                '/profile_screen': (context) => const ProfileScreen(),
                '/location_screen': (context) => const LocationScreen(),
                '/command_list_screen': (context) => const CommandListScreen(),
                '/scan_screen': (context) => const ScanScreen(),
                '/forget_password_first_screen': (context) =>
                    const ForgetPwdOneScreen(),
                '/forget_password_second_screen': (context) =>
                    const ForgetPwdTwoScreen(),
                '/forget_password_third_screen': (context) =>
                    const ForgetPwdTwoScreen(),
                '/detail_command_screen': (context) =>
                    const DetailCommandScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
